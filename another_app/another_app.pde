import java.io.IOException;

Runtime rt;


void setup () 
{
    size (800, 800);
    try {
        rt = Runtime.getRuntime ();
        rt.exec ("C:/Program Files (x86)/Google/Chrome/Application/chrome.exe");
    } catch (IOException ex) {
        ex.printStackTrace ();
    }
}

void draw () 
{

}
