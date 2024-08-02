import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import javax.swing.JFrame;
import javax.swing.SwingUtilities;

import quick.dbtable.DBTable;

import javax.swing.JLabel;
import javax.swing.JOptionPane;

import java.awt.Font;
import javax.swing.JTextField;
import javax.swing.JPasswordField;
import javax.swing.ButtonGroup;
import javax.swing.ImageIcon;
import javax.swing.JButton;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;
import java.awt.event.KeyEvent;
import javax.swing.JRadioButton;

public class Login extends JFrame {
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	private JTextField user;
	private JPasswordField password;
	private ButtonGroup botones;
	private JRadioButton btnAdmin, btnInspec;
	private JLabel lblUser, lblPass;
	private JButton btnLogin;
	private Admin adm; // Ventana administrador
	private Inspector ins; // Ventana inspector
	public DBTable table; // Es la tabla que usaremos para la conexion a la BD
	private String[] datos; // Es para ponerle el nombre del inspector al titulo de su ventana
	private JLabel lblNewLabel;

	public static void main(String args[]) {
		SwingUtilities.invokeLater(new Runnable() {
			public void run() {
				Login login = new Login();
				login.setIconImage(new ImageIcon(getClass().getResource("logo.png")).getImage());
				login.setSize(520, 300);
				login.setResizable(false);
				login.setLocationRelativeTo(null);
				login.setVisible(true);
				login.setDefaultCloseOperation(EXIT_ON_CLOSE);

			}
		});

	}

	public Login() {
		setTitle("LINKIN PARKING 2020 - LOGIN");
		getContentPane().setLayout(null);

		user = new JTextField();
		user.setBounds(101, 89, 113, 20);
		getContentPane().add(user);
		user.setColumns(10);

		password = new JPasswordField();
		password.setBounds(320, 89, 113, 20);
		getContentPane().add(password);

		table = new DBTable();

		lblUser = new JLabel("Usuario:");
		lblUser.setFont(new Font("Copperplate Gothic Bold", Font.PLAIN, 14));
		lblUser.setBounds(32, 90, 68, 14);
		getContentPane().add(lblUser);

		lblPass = new JLabel("Contrase\u00F1a:");
		lblPass.setFont(new Font("Copperplate Gothic Bold", Font.PLAIN, 14));
		lblPass.setBounds(226, 90, 84, 14);
		getContentPane().add(lblPass);

		btnLogin = new JButton("Iniciar sesi\u00F3n");
		btnLogin.setFont(new Font("Copperplate Gothic Bold", Font.PLAIN, 11));
		btnLogin.setBounds(192, 187, 132, 23);
		btnLogin.setMnemonic(KeyEvent.VK_ENTER);
		getContentPane().add(btnLogin);

		btnAdmin = new JRadioButton("Administrador", true);
		btnAdmin.setFont(new Font("Copperplate Gothic Bold", Font.PLAIN, 11));
		btnAdmin.setBounds(101, 131, 113, 23);
		getContentPane().add(btnAdmin);

		btnInspec = new JRadioButton("Inspector", false);
		btnInspec.setFont(new Font("Copperplate Gothic Bold", Font.PLAIN, 11));
		btnInspec.setBounds(320, 131, 76, 23);
		getContentPane().add(btnInspec);

		botones = new ButtonGroup();
		botones.add(btnAdmin);
		botones.add(btnInspec);

		lblNewLabel = new JLabel("Seleccione su tipo de usuario");
		lblNewLabel.setFont(new Font("Tahoma", Font.PLAIN, 16));
		lblNewLabel.setBounds(143, 26, 223, 14);
		getContentPane().add(lblNewLabel);

		btnLogin.addActionListener(new ActionListener() {
			@SuppressWarnings("deprecation")
			public void actionPerformed(ActionEvent arg0) {
				conectarBD(user.getText(), password.getText());
			}
		});

		btnAdmin.addActionListener(new ActionListener() {
			public void actionPerformed(ActionEvent arg0) {
				if (btnAdmin.isSelected())
					lblUser.setText("Usuario:");

			}
		});

		btnInspec.addActionListener(new ActionListener() {
			public void actionPerformed(ActionEvent arg0) {
				if (btnInspec.isSelected())
					lblUser.setText("Legajo:");

			}
		});

	}

	/*
	 * Inicializa la base de datos, ingresando como admin o como inspector segun sea
	 * el usuario. Si es un inspector, se valida que los datos del mismo (legajo y
	 * password) sean los correctos. Cualquier error es notificado mediante un
	 * cartel.
	 */
	private void conectarBD(String user, String pw) {
		try {
			String driver = "com.mysql.cj.jdbc.Driver";
			String server = "localhost:3306";
			String bdd = "parquimetros";
			String url = "jdbc:mysql://" + server + "/" + bdd + "?serverTimezone=America/Argentina/Buenos_Aires";
			if (btnAdmin.isSelected() && pw.equals("admin")) {
				table.connectDatabase(driver, url, user, pw);
				adminScreen();
			} else if (btnInspec.isSelected()) {
				table.connectDatabase(driver, url, "inspector", "inspector");
				if (checkInspector(user, pw))
					inspecScreen(user);
				else
					JOptionPane.showMessageDialog(getContentPane(), "Legajo o contraseña incorrectos", "ERROR",
							JOptionPane.WARNING_MESSAGE);

			} else {
				JOptionPane.showMessageDialog(getContentPane(), "Usuario o Password incorrecto. Intente nuevamente.",
						"ERROR", JOptionPane.WARNING_MESSAGE);
			}

		} catch (SQLException ex) {

		} catch (ClassNotFoundException e) {

		}
	}

	/*
	 * Verifica que el legajo (user) y el password (pw) correspondan a un inspector
	 * de la base de datos.
	 */
	private boolean checkInspector(String user, String pw) {
		boolean salida = true;
		Connection c = table.getConnection();
		try {
			Statement st = c.createStatement();
			ResultSet rs = st.executeQuery("select nombre,apellido from inspectores where legajo='" + user
					+ "' and password=md5('" + pw + "')");
			salida = rs.next();

			datos = new String[2];
			datos[0] = rs.getString("nombre");
			datos[1] = rs.getString("apellido");

			st.close();
			rs.close();

		} catch (SQLException e) {

		}

		return salida;

	}

	/*
	 * Cambia a la ventana de la funcion del administrador y cierra la ventana
	 * inicial
	 */
	private void adminScreen() {
		adm = new Admin(this, table);
		adm.setTitle("LINKIN PARKING 2020 - Panel Administrador");
		adm.setIconImage(new ImageIcon(getClass().getResource("logo.png")).getImage());
		adm.setSize(1000, 600);
		adm.setVisible(true);
		adm.setLocationRelativeTo(null);
		adm.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
		this.dispose();
	}

	/*
	 * Cambia a la ventana de la funcion del inspector y cierra la ventana inicial
	 */
	private void inspecScreen(String user) {
		ins = new Inspector(user);
		ins.setTitle("Inspector " + datos[0] + " " + datos[1] + " - LINKIN PARKING 2020");
		ins.setIconImage(new ImageIcon(getClass().getResource("logo.png")).getImage());
		ins.setSize(711, 600);
		ins.setVisible(true);
		ins.setLocationRelativeTo(null);
		ins.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
		this.dispose();
	}
}