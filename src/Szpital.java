import org.w3c.dom.*;
import org.w3c.dom.bootstrap.DOMImplementationRegistry;
import org.w3c.dom.ls.*;

import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.util.Scanner;

public class Szpital {
    public static Document document;

    public static void main(String[] args) throws InstantiationException, IllegalAccessException, ClassNotFoundException, FileNotFoundException {

        //Konfiguracja
        DOMImplementationRegistry registry = DOMImplementationRegistry.newInstance();
        DOMImplementationLS impl = (DOMImplementationLS) registry.getDOMImplementation("LS");
        LSParser builder = impl.createLSParser(DOMImplementationLS.MODE_SYNCHRONOUS, null);
        DOMConfiguration config = builder.getDomConfig();
        DOMErrorHandler errorHandler = getErrorHandler();
        config.setParameter("error-handler", errorHandler);
        config.setParameter("validate", Boolean.TRUE);
        config.setParameter("schema-type", "http://www.w3.org/2001/XMLSchema");
        config.setParameter("schema-location",  args[1]);
        //
        System.out.println("Parsowanie " + args[0] + "...");
        document = builder.parseURI(args[0]);

        //Nowy lekarz
        Element elem = document.getElementById("L1");
        Element newElem = (Element) elem.cloneNode(true);
        newElem.setAttribute("id", "L5");
        newElem.setAttribute("plec", "m");
        newElem.setAttribute("oddzial","Kardiologiczny");
        NodeList nl = newElem.getChildNodes();
        for(int i = 0; i < nl.getLength(); i++){
            Node n = nl.item(i);
            if(n.getNodeName().equals("imie")){
                n.setTextContent("Maria");
            }
            if(n.getNodeName().equals("nazwisko"))
            {
                n.setTextContent("Kazimierzak");
            }
            if(n.getNodeName().equals("data_ur"))
            {
                n.setTextContent("1979-01-13");
            }
            if(n.getNodeName().equals("specjalizacja"))
            {
                n.setTextContent("Kardiologia");
            }
            if(n.getNodeName().equals("pensja"))
            {
                n.setTextContent("11000");
            }
        }
        document.getFirstChild().insertBefore(newElem,null);

        //Usunięcie ratownika medycznego który nie jest dostępny

        NodeList nodeList = document.getElementsByTagName("dostepnosc");
        for (int i = 0; i < nodeList.getLength(); i++) {
            Element element = (Element) nodeList.item(i);
            if(element.getTextContent().equals("NIE")){
                Node grandParent = element.getParentNode().getParentNode();
                grandParent.removeChild(element.getParentNode());
                i-=1;
            }
        }

        //Wypisanie pacjentów
        NodeList nl1 = document.getElementsByTagName("pacjent");
        for(int i = 0; i < nl1.getLength(); i++){
            Node node = nl1.item(i);
            Element element = (Element)  node;
            String id = element.getAttribute("plec");
            String plec = element.getAttribute("id");
            String id_lekarza = element.getAttribute("id_lekarza");
            Node node_imie = elem.getElementsByTagName("imie").item(0);
            String imie = node_imie.getTextContent();
            Node node_nazwisko = elem.getElementsByTagName("nazwisko").item(0);
            String nazwisko = node_nazwisko.getTextContent();
            Node pesel = elem.getElementsByTagName("pesel").item(0);
            String psl = pesel.getTextContent();
            Node diagnoza = elem.getElementsByTagName("diagnoza").item(0);
            String diag = diagnoza.getTextContent();
            Node oddzial = elem.getElementsByTagName("oddzial").item(0);
            String odd = oddzial.getTextContent();

            System.out.println("Id =" + id);
            System.out.println("Plec = " + plec);
            System.out.println("Id lekarza: " + id_lekarza);
            System.out.println("Imie: "+imie);
            System.out.println("Nazwisko: "+nazwisko);
            System.out.println("Pesel: "+psl);
            System.out.println("Diagnoza: "+diag);
            System.out.println("Odzdzial: "+ odd);
            System.out.println("--------------------------------");

        }



        //Serializacja
        LSSerializer writer = impl.createLSSerializer();
        config = writer.getDomConfig();
        config.setParameter("xml-declaration", Boolean.TRUE);
        LSOutput out = impl.createLSOutput();
        out.setEncoding("latin2");
        out.setByteStream(new FileOutputStream("dom_" + args[0]));
        writer.write(document, out);
        //

    }

    public static DOMErrorHandler getErrorHandler() {
        return new DOMErrorHandler() {
            public boolean handleError(DOMError error) {
                short severity = error.getSeverity();
                if (severity == error.SEVERITY_ERROR) {
                    System.out.println("[dom3-error]: " + error.getMessage());
                }
                if (severity == error.SEVERITY_WARNING) {
                    System.out.println("[dom3-warning]: " + error.getMessage());
                }
                if (severity == error.SEVERITY_FATAL_ERROR) {
                    System.out.println("[dom3-fatal-error]: "
                            + error.getMessage());
                }
                return true;
            }
        };
    }
}
