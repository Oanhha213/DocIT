// BTVN2.cpp : Defines the entry point for the application.
//

#include "framework.h"
#include "BTVN2.h"

#define MAX_LOADSTRING 100
#define ID_LBNAME 1
#define ID_EDNAME 2
#define ID_LBPHONE 3
#define ID_EDPHONE 4
#define ID_GBMENU 5
#define ID_GBSELECTDISH 6
#define ID_LTMENU 7
#define ID_LTSELECTDISH 8
#define ID_LBMONEY 9
#define ID_MONEY 10
#define ID_BTORDER 11
#define ID_BTRESELECT 12
#define ID_BTEXIT 13
// Global Variables:
HINSTANCE hInst;                                // current instance
WCHAR szTitle[MAX_LOADSTRING];                  // The title bar text
WCHAR szWindowClass[MAX_LOADSTRING];            // the main window class name
HWND hWndLBName, hWndEDName, hWndLBPhone, hWndEDPhone, hWndGBMenu, hWndGBSelectDish, hWndLTMenu, hWndLTSLD,
hWndLBMoney, hWndMoney, hWndBTOrder, hWndBTReselect, hWndBTExit;
// Forward declarations of functions included in this code module:
ATOM                MyRegisterClass(HINSTANCE hInstance);
BOOL                InitInstance(HINSTANCE, int);
LRESULT CALLBACK    WndProc(HWND, UINT, WPARAM, LPARAM);
INT_PTR CALLBACK    About(HWND, UINT, WPARAM, LPARAM);

int APIENTRY wWinMain(_In_ HINSTANCE hInstance,
                     _In_opt_ HINSTANCE hPrevInstance,
                     _In_ LPWSTR    lpCmdLine,
                     _In_ int       nCmdShow)
{
    UNREFERENCED_PARAMETER(hPrevInstance);
    UNREFERENCED_PARAMETER(lpCmdLine);

    // TODO: Place code here.

    // Initialize global strings
    LoadStringW(hInstance, IDS_APP_TITLE, szTitle, MAX_LOADSTRING);
    LoadStringW(hInstance, IDC_BTVN2, szWindowClass, MAX_LOADSTRING);
    MyRegisterClass(hInstance);

    // Perform application initialization:
    if (!InitInstance (hInstance, nCmdShow))
    {
        return FALSE;
    }

    HACCEL hAccelTable = LoadAccelerators(hInstance, MAKEINTRESOURCE(IDC_BTVN2));

    MSG msg;

    // Main message loop:
    while (GetMessage(&msg, nullptr, 0, 0))
    {
        if (!TranslateAccelerator(msg.hwnd, hAccelTable, &msg))
        {
            TranslateMessage(&msg);
            DispatchMessage(&msg);
        }
    }

    return (int) msg.wParam;
}



//
//  FUNCTION: MyRegisterClass()
//
//  PURPOSE: Registers the window class.
//
ATOM MyRegisterClass(HINSTANCE hInstance)
{
    WNDCLASSEXW wcex;

    wcex.cbSize = sizeof(WNDCLASSEX);

    wcex.style          = CS_HREDRAW | CS_VREDRAW;
    wcex.lpfnWndProc    = WndProc;
    wcex.cbClsExtra     = 0;
    wcex.cbWndExtra     = 0;
    wcex.hInstance      = hInstance;
    wcex.hIcon          = LoadIcon(hInstance, MAKEINTRESOURCE(IDI_BTVN2));
    wcex.hCursor        = LoadCursor(nullptr, IDC_ARROW);
    wcex.hbrBackground  = (HBRUSH)(COLOR_WINDOW+1);
    wcex.lpszMenuName   = MAKEINTRESOURCEW(IDC_BTVN2);
    wcex.lpszClassName  = szWindowClass;
    wcex.hIconSm        = LoadIcon(wcex.hInstance, MAKEINTRESOURCE(IDI_SMALL));

    return RegisterClassExW(&wcex);
}

//
//   FUNCTION: InitInstance(HINSTANCE, int)
//
//   PURPOSE: Saves instance handle and creates main window
//
//   COMMENTS:
//
//        In this function, we save the instance handle in a global variable and
//        create and display the main program window.
//
BOOL InitInstance(HINSTANCE hInstance, int nCmdShow)
{
   hInst = hInstance; // Store instance handle in our global variable

   HWND hWnd = CreateWindowW(szWindowClass, szTitle, WS_OVERLAPPEDWINDOW,
      CW_USEDEFAULT, 0, CW_USEDEFAULT, 0, nullptr, nullptr, hInstance, nullptr);

   if (!hWnd)
   {
      return FALSE;
   }

   ShowWindow(hWnd, nCmdShow);
   UpdateWindow(hWnd);

   return TRUE;
}

//
//  FUNCTION: WndProc(HWND, UINT, WPARAM, LPARAM)
//
//  PURPOSE: Processes messages for the main window.
//
//  WM_COMMAND  - process the application menu
//  WM_PAINT    - Paint the main window
//  WM_DESTROY  - post a quit message and return
//
//
LRESULT CALLBACK WndProc(HWND hWnd, UINT message, WPARAM wParam, LPARAM lParam)
{
    switch (message)
    {
    case WM_CREATE:
        hWndLBName = CreateWindow(TEXT("static"), TEXT("Họ tên khách"), WS_CHILD | WS_VISIBLE,
            50, 50, 100, 15, hWnd, (HMENU)ID_LBNAME, NULL, NULL);
        hWndEDName = CreateWindow(TEXT("edit"), TEXT(""), WS_CHILD | WS_VISIBLE | WS_BORDER ,
            170, 40, 150, 30, hWnd, (HMENU)ID_EDNAME, NULL, NULL);
        hWndLBPhone = CreateWindow(TEXT("static"), TEXT("Điện thoại"), WS_CHILD | WS_VISIBLE,
            500, 50, 80, 15, hWnd, (HMENU)ID_LBPHONE, NULL, NULL);
        hWndEDPhone = CreateWindow(TEXT("edit"), TEXT(""), WS_CHILD | WS_VISIBLE | WS_BORDER,
            600, 40, 150, 30, hWnd, (HMENU)ID_EDPHONE, NULL, NULL);
        hWndGBMenu = CreateWindow(TEXT("button"), TEXT("Thực đơn"),BS_GROUPBOX | WS_CHILD | WS_VISIBLE, 
            50, 100, 400, 200, hWnd, (HMENU)ID_GBMENU, NULL, NULL);
        hWndGBSelectDish = CreateWindow(TEXT("button"), TEXT("Các món đã chọn"), BS_GROUPBOX | WS_CHILD | WS_VISIBLE,
            500, 100, 400, 200, hWnd, (HMENU)ID_GBSELECTDISH, NULL, NULL);
        hWndLTMenu = CreateWindow(TEXT("listbox"), TEXT(""), WS_CHILD | WS_VISIBLE | WS_BORDER | LBS_NOTIFY,
            60, 120, 380, 150, hWnd, (HMENU)ID_LTMENU, NULL, NULL);
        hWndLTSLD = CreateWindow(TEXT("listbox"), TEXT(""), WS_CHILD | WS_VISIBLE | WS_BORDER | LBS_NOTIFY,
            510, 120, 380, 150, hWnd, (HMENU)ID_LTSELECTDISH, NULL, NULL);
        hWndBTOrder = CreateWindow(TEXT("button"), TEXT("Đặt bàn"), WS_CHILD | WS_VISIBLE ,
            100, 400, 100, 40, hWnd, (HMENU)ID_BTORDER, NULL, NULL);
        hWndBTReselect= CreateWindow(TEXT("button"), TEXT("Chọn lại"), WS_CHILD | WS_VISIBLE ,
            300, 400, 100, 40, hWnd, (HMENU)ID_BTRESELECT, NULL, NULL);
        hWndBTExit = CreateWindow(TEXT("button"), TEXT("Thoát"), WS_CHILD | WS_VISIBLE ,
            820, 400, 70, 30, hWnd, (HMENU)ID_BTEXIT, NULL, NULL);
        break;
    case WM_COMMAND:
        {
            int wmId = LOWORD(wParam);
            // Parse the menu selections:
            switch (wmId)
            {
            case ID_BTEXIT:
                if (MessageBox(NULL, TEXT("Bạn có muốn thoát không?"), TEXT("Thông báo"), MB_ICONQUESTION | MB_YESNO) == IDYES)
                    DestroyWindow(hWnd);
                break;
            case IDM_ABOUT:
                DialogBox(hInst, MAKEINTRESOURCE(IDD_ABOUTBOX), hWnd, About);
                break;
            case IDM_EXIT:
                DestroyWindow(hWnd);
                break;
            default:
                return DefWindowProc(hWnd, message, wParam, lParam);
            }
        }
        break;
    case WM_PAINT:
        {
            PAINTSTRUCT ps;
            HDC hdc = BeginPaint(hWnd, &ps);
            // TODO: Add any drawing code that uses hdc here...
            EndPaint(hWnd, &ps);
        }
        break;
    case WM_DESTROY:
        PostQuitMessage(0);
        break;
    default:
        return DefWindowProc(hWnd, message, wParam, lParam);
    }
    return 0;
}

// Message handler for about box.
INT_PTR CALLBACK About(HWND hDlg, UINT message, WPARAM wParam, LPARAM lParam)
{
    UNREFERENCED_PARAMETER(lParam);
    switch (message)
    {
    case WM_INITDIALOG:
        return (INT_PTR)TRUE;

    case WM_COMMAND:
        if (LOWORD(wParam) == IDOK || LOWORD(wParam) == IDCANCEL)
        {
            EndDialog(hDlg, LOWORD(wParam));
            return (INT_PTR)TRUE;
        }
        break;
    }
    return (INT_PTR)FALSE;
}
