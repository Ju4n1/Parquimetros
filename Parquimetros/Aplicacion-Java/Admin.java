import javax.swing.JFrame;
import quick.dbtable.DBTable;

import javax.swing.JTextArea;
import javax.swing.ListSelectionModel;
import javax.swing.JList;
import javax.swing.JOptionPane;
import javax.swing.ImageIcon;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;
import java.awt.event.MouseAdapter;
import java.awt.event.MouseEvent;
import java.awt.event.MouseListener;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.sql.Types;
import javax.swing.DefaultListModel;
import javax.swing.JButton;
import javax.swing.JLabel;
import java.awt.Color;

public class Admin extends JFrame {
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	private DBTable table;
	private JTextArea textArea;
	private JList<String> listTablas, listAtributos;
	private JButton btnEjecutar, btnRegresar;
	private JLabel lblTablas, lblAtributos;
	private Login login;
	
	public Admin(Login prev, DBTable t) {
		table = t;
		login = prev;
		listAtributos = new JList<String>();
		listTablas = new JList<String>();

		listTablas.setSelectionMode(ListSelectionModel.SINGLE_INTERVAL_SELECTION);

		listarTablas();

		MouseListener mouseListener = new MouseAdapter() {
			public void mouseClicked(MouseEvent e) {
				listarAtributos(listTablas.getSelectedValue());
			}
		};
		listTablas.addMouseListener(mouseListener);
		setIconImage(new ImageIcon(getClass().getResource("logo.png")).getImage());
		getContentPane().setLayout(null);

		textArea = new JTextArea();
		textArea.setBackground(Color.LIGHT_GRAY);
		textArea.setBounds(169, 12, 464, 36);
		getContentPane().add(textArea);

		table.setEditable(false);
		table.setBounds(0, 100, 600, 460);
		getContentPane().add(table);

		btnEjecutar = new JButton("Ejecutar");
		btnEjecutar.setBounds(655, 13, 89, 35);
		getContentPane().add(btnEjecutar);
		btnEjecutar.addActionListener(new ActionListener() {
			public void actionPerformed(ActionEvent arg0) {
				
				String consulta = textArea.getText();
				if(!consulta.equals("")) {
					int estadoConsulta = consultaAdmin(table, consulta);
					if(estadoConsulta == 2) {
						table.setVisible(true);
						JOptionPane.showMessageDialog(null, "Consulta exitosa", "Exito", JOptionPane.INFORMATION_MESSAGE);
						
					}
					else {
						 
						 if(estadoConsulta == 1 ) {
							 table.setVisible(true);
							 JOptionPane.showMessageDialog(null, "Sentencia Ejecutada", "Exito", JOptionPane.INFORMATION_MESSAGE);
							
						 }
						 else {
						 JOptionPane.showMessageDialog(null, "La consulta falló", "Error", JOptionPane.ERROR_MESSAGE);
						 }
						 
					 }
				}
				else {
					JOptionPane.showMessageDialog(null, "No se ingreso una consulta", "Error", JOptionPane.ERROR_MESSAGE);
				}
				
			
				
				
			}
				
			
		});

		lblTablas = new JLabel("Lista de tablas");
		lblTablas.setBounds(678, 81, 89, 14);
		getContentPane().add(lblTablas);

		lblAtributos = new JLabel("Lista de atributos");
		lblAtributos.setBounds(834, 79, 103, 14);
		getContentPane().add(lblAtributos);

		btnRegresar = new JButton("Volver");
		btnRegresar.addActionListener(new ActionListener() {
			public void actionPerformed(ActionEvent arg0) {
				regresarLogin();

			}
		});
		btnRegresar.setBounds(853, 13, 84, 35);
		getContentPane().add(btnRegresar);

		JLabel lblNewLabel = new JLabel("Ingrese su consulta aqui:");
		lblNewLabel.setBounds(16, 17, 143, 14);
		getContentPane().add(lblNewLabel);
		
		JButton btnNewButton = new JButton("Borrar");
		btnNewButton.addActionListener(new ActionListener() {
			public void actionPerformed(ActionEvent arg0) {
				textArea.setText("");
				table.setVisible(false);
			}
		});
		btnNewButton.setBounds(754, 13, 89, 35);
		getContentPane().add(btnNewButton);

	}

	/*
	 * Genera y muestra en la app la lista de tablas de la BD Parquimetros
	 */
	private void listarTablas() {
		DefaultListModel<String> listModel = new DefaultListModel<String>();
		Connection c = table.getConnection();
		try {
			Statement st = c.createStatement();
			ResultSet rs = st.executeQuery("show tables");
			boolean fin = rs.next();
			while (fin) {
				listModel.addElement(rs.getString("Tables_in_parquimetros"));
				fin = rs.next();
			}
			listTablas.setModel(listModel);
			listTablas.setBounds(638, 100, 162, 272);
			getContentPane().add(listTablas);
			rs.close();
			st.close();

		} catch (SQLException e) {
			
		}
	}

	/*
	 * Dada la tabla seleccionada en la lista de tablas, muestra sus atributos en la
	 * app
	 */
	private void listarAtributos(String selected) {
		DefaultListModel<String> listModel = new DefaultListModel<String>();
		Connection c = table.getConnection();
		try {
			Statement st = c.createStatement();
			ResultSet rs = st.executeQuery("describe " + selected);
			boolean fin = rs.next();
			while (fin) {
				listModel.addElement(rs.getString("Field"));
				fin = rs.next();
			}
			listAtributos.setModel(listModel);
			listAtributos.setBounds(804, 100, 162, 272);
			getContentPane().add(listAtributos);
			rs.close();
			st.close();

		} catch (SQLException e) {
		
		}
	}

	
	private void regresarLogin() {
		try {
			table.close();
		} catch (SQLException e) {
			e.printStackTrace();
		}
		login = new Login();
		login.setSize(520, 300);
		login.setResizable(false);
		login.setLocationRelativeTo(null);
		login.setVisible(true);
		login.setDefaultCloseOperation(EXIT_ON_CLOSE);

		this.dispose();

	}


//Devuelve una tabla q es el resultado de la sentencia SQL pasada por parametro
	public int consultaAdmin(DBTable tabla,String sentencia)
	{  
		int toReturn = 0;
		try
	    { 
			
			Statement stmt = tabla.getConnection().createStatement();
			  
			stmt.execute(sentencia);
			
			ResultSet rs = stmt.getResultSet();
			
			toReturn = 1;
			
		 if(rs  != null) {
			 
			toReturn = 2; 
		   // coneAdmin.conectarBD(tabla);	
		    tabla.setSelectSql(sentencia);
		    tabla.createColumnModelFromQuery(); 
		
		
		 for (int i = 0; i < tabla.getColumnCount(); i++)
		  { // para que muestre correctamente los valores de tipo TIME (hora)  		   		  
			 if	 (tabla.getColumn(i).getType()==Types.TIME)  
			 {    		 
			  tabla.getColumn(i).setType(Types.CHAR);  
		       	 }
			 // cambiar el formato en que se muestran los valores de tipo DATE
			 if	 (tabla.getColumn(i).getType()==Types.DATE)
			 {
				 tabla.getColumn(i).setDateFormat("dd/MM/YYYY");
			 }
	     }  
		
		 tabla.refresh();
		 
		 
		 }
	    }
	    catch (SQLException ex)
	    {
	     
	       JOptionPane.showMessageDialog(null,
                 ex.getMessage() + "\n", 
                 "Error al ejecutar la sentencia SQL.",
                 JOptionPane.ERROR_MESSAGE);
	    }	
		return toReturn;
		
		
	}
}