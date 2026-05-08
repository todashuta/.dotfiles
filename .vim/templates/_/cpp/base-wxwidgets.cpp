#include <wx/wx.h>

class MyApp : public wxApp
{
public:
	bool OnInit() override;
};

wxIMPLEMENT_APP(MyApp);

class MyFrame : public wxFrame
{
public:
	MyFrame();
};

bool MyApp::OnInit()
{
	MyFrame *frame = new MyFrame();
	frame->Show(true);
	return true;
}

MyFrame::MyFrame() : wxFrame(nullptr, wxID_ANY, "Hello World")
{
}
