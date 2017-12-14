package com.uscc.CallDump;

import java.io.StringReader;
import java.util.Hashtable;
import java.util.Vector;
import org.apache.xerces.parsers.DOMParser;
import org.w3c.dom.Document;
import org.w3c.dom.NamedNodeMap;
import org.w3c.dom.Node;
import org.w3c.dom.NodeList;
import org.xml.sax.InputSource;

/**
 *
 * <p><b>XMLdomReader</b></p>
 * <p><b>Description:</b> An XML Dom Parser that can read any well formed XML document
 * ,parse it, then place it into memory.
 * After it has been parsed, we can access specific subtrees
 * through the public methods.
 * </p>
 * <p>Copyright: Copyright (c) 2005</p>
 * <p>US Cellular</p>
 * @author David Balchen
 * @version 1.0
 */

public class XMLdomReader {
	
	/** Date File was Last Modified */
	public static final String LASTMODIFIEDDATE =
		"$Date:   24 Jun 2004 16:24:38  $";
	/** Version of this file */
	public static final String LASTMODIFIEDVERSION = "$Revision:   1.0.1.2  $";
	/** Last person to modify this file */
	public static final String LASTMODIFIEDBY = "$Author:   pvcs  $";
	
	/**
	 * @uml.property  name="map"
	 * @uml.associationEnd  multiplicity="(0 -1)" elementType="java.util.Hashtable"
	 */
	private Vector<Hashtable<String, String>> Map = null;
	/**
	 * @uml.property  name="doc"
	 * @uml.associationEnd  
	 */
	private Document doc = null;
	/**
	 * @uml.property  name="root"
	 * @uml.associationEnd  
	 */
	private org.w3c.dom.Element root;
	
	/**
	 * Constructs an instance of the XMLdomReader object with a XML file.
	 */
	public XMLdomReader(String name) {
		
		try {
			parseFileXML(name);
		}
		catch (Exception e) {
			System.out.println("Could not parse the XML file -- Exit the program");
			e.printStackTrace();
			System.exit(2);
		}
	}
	
	/**
	 * Constructs an instance of the XMLdomReader object with default values
	 */
	
	public XMLdomReader() {
		
	}
	
	/**
	 * Takes an XML file, parses it and places it in memory.
	 * @param XML file
	 * @throws java.lang.Exception
	 */
	public void parseFileXML(String fileName) throws Exception {
		DOMParser parser = new DOMParser();
		parser.parse(fileName);
		doc = parser.getDocument();
		root = (org.w3c.dom.Element) doc.getDocumentElement();
	}
	
	public void parseStringXML(String xmlData)throws Exception {
		
	    DOMParser parser = new DOMParser();
	    parser.parse(new InputSource(new StringReader(xmlData.toString())));
	    doc = parser.getDocument();
		root = (org.w3c.dom.Element) doc.getDocumentElement();

	}
	
	/**
	 * Method which returns a vector containing the subtree from a given tag.
	 * @param tag -- Get a subtree from this tag and all children
	 * @param ListItem -- If multiple instances of a certain tag, get
	 *                    this instance.
	 * @return Returns a vector containing all tags, there
	 *            values and attributes.
	 * @throws java.lang.Exception
	 */
	public Vector<Hashtable<String, String>> getSubTree(String tag, int ListItem, String target) throws
	Exception {
		
		Vector<Hashtable<String, String>> Vec = new Vector<Hashtable<String, String>>();
		NodeList tags = root.getElementsByTagName(tag);
		Node tagsnode = tags.item(ListItem);
		
		Map = Vec;
		getMappingTree(tagsnode, ListItem,target);
		return Map;
	}
	
	public Vector<Hashtable<String, String>> getSubTree(String tag, int ListItem) throws
	Exception {
		
		return getSubTree(tag,ListItem,null);
	}
	
	public Vector<Hashtable<String, String>> getTags(String startTag, String target) throws Exception
	{
		return getSubTree(startTag,0,target);
	}
	/**
	 * Method which returns a vector containing the subtree from a given tag.
	 * This returns the subtree from the first instance of a tag.
	 * @param tag -- Get a subtree from this tag and all children
	 * @return Returns a vector containing all tags, there
	 *            values and attributes.
	 * @throws java.lang.Exception
	 */
	public Vector<Hashtable<String, String>> getSubTree(String tag) throws Exception {
		return getSubTree(tag, 0);
	}
	
	/**
	 * Method which returns a tags value.
	 * @param tag -- Get this Tag value
	 * @param ListItem -- If multiple instances of a certain tag, get
	 *                    this instance.
	 * @return A String with the tags value.
	 */
	public String getTagValue(String tag, int ListItem) {
		NodeList children = root.getElementsByTagName(tag);
		if (children.getLength() > 0) {
			Node childNode = children.item(ListItem).getFirstChild();
			if (childNode != null) {
				return childNode.getNodeValue();
			}
		}
		return null; // Return null if value not found.
	}
	
	/**
	 * Method which returns the first instance of a tags value.
	 * @param tag -- Get this Tag value.
	 * @return  A String with the tags value.
	 */
	public String getTagValue(String tag) {
		return getTagValue(tag, 0);
	}
	
	/**
	 * Method which returns all values for a given tag.
	 * @param tag -- Get all values for this tag.
	 * @return Returns a vector that contains the value for each instance
	 *            of a tag.
	 */
	public Vector<String> getAllTagValue(String tag) {
		Vector<String> List = new Vector<String>();
		NodeList children = root.getElementsByTagName(tag);
		for (int a = 0; a < children.getLength(); a++) {
			List.addElement(getTagValue(tag, a));
		}
		return List;
	}
	
	/**
	 *
	 * @param Tag -- Find all instances of this tag then returns all child nodes.
	 * @param childnum -- Child Depth
	 * @return -- Returns a vector for a given tag of depth childnum.
	 * @throws java.lang.Exception
	 */
	public Vector<Hashtable<String, String>> getChildTags(String Tag, int childnum) throws Exception {
		Vector<Hashtable<String, String>> List = new Vector<Hashtable<String, String>>();
		Vector<Hashtable<String, String>> prelist = getSubTree(Tag);
		
		for (int a = 1; a < prelist.size(); a++) {
			if (Integer.parseInt( ( (Hashtable<String, String>) prelist.get(a)).get(
			"CHILD_NUM")) == childnum) {
				List.add(prelist.get(a));
			}
		}
		
		return List;
	}
	
	private void getMappingTree(Node node, int childnum, String target) throws Exception {
		Node atNode = null;
		Hashtable<String, String> MapAttr = new Hashtable<String, String>();
		MapAttr.put("TAG_NAME", node.getNodeName());
		
		if (node.getNodeType() == Node.TEXT_NODE) {
			if (node.getNodeValue() != null) {
				MapAttr.put("TAG_VALUE", node.getNodeValue());
			}
		}
		else if (node.getNodeType() == Node.ELEMENT_NODE) {
			try {
				if (node.getFirstChild().getNodeValue() != null) {
					MapAttr.put("TAG_VALUE", node.getFirstChild().getNodeValue());
				}
			}
			catch (Exception e) {
				MapAttr.put("TAG_VALUE", "");
			}
		}
		
		MapAttr.put("CHILD_NUM", Integer.toString(childnum));
		
		NamedNodeMap attrs = node.getAttributes();
		int attNum = attrs.getLength();
		
		if (attNum > 0) {
			for (int a = 0; a < attNum; a++) {
				atNode = attrs.item(a);
				MapAttr.put(atNode.getNodeName(), atNode.getNodeValue());
			}
		}
		
		if (MapAttr.get("TAG_NAME").equals(target) || target == null )
		{
			Map.addElement(MapAttr);
		}
		if (node.hasChildNodes()) {
			Vector<Node> childNodes = getElementNodes(node.getChildNodes());
			
			int nextchildnum = childnum + 1;
			
			for (int i = 0; i < childNodes.size(); i++) {
				Node childNode = childNodes.elementAt(i);
				getMappingTree(childNode, nextchildnum, target);
			}
		}
		return;
	}
	
	private String getAttrValue(NamedNodeMap attrList, String name) {
		String value = null;
		if (attrList.getNamedItem(name) != null) {
			value = attrList.getNamedItem(name).getNodeValue();
		}
		return value;
	}
	
	private Vector<Node> getElementNodes(NodeList nodes) {
		Vector<Node> elemNodes = new Vector<Node>();
		for (int i = 0; i < nodes.getLength(); i++) {
			if (nodes.item(i).getNodeType() == Node.ELEMENT_NODE) {
				elemNodes.addElement(nodes.item(i));
			}
		}
		return elemNodes;
	}
	
}
