function varargout = browse(varargin)
% BROWSE MATLAB code for browse.fig
%      BROWSE, by itself, creates a new BROWSE or raises the existing
%      singleton*.
%
%      H = BROWSE returns the handle to a new BROWSE or the handle to
%      the existing singleton*.
%
%      BROWSE('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in BROWSE.M with the given input arguments.
%
%      BROWSE('Property','Value',...) creates a new BROWSE or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before browse_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to browse_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help browse

% Last Modified by GUIDE v2.5 05-Apr-2019 10:16:25

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @browse_OpeningFcn, ...
                   'gui_OutputFcn',  @browse_OutputFcn, ...
                   'gui_LayoutFcn',  [] , ...
                   'gui_Callback',   []);
if nargin && ischar(varargin{1})
    gui_State.gui_Callback = str2func(varargin{1});
end

if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end
% End initialization code - DO NOT EDIT


% --- Executes just before browse is made visible.
function browse_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to browse (see VARARGIN)

% Choose default command line output for browse
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes browse wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = browse_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;
 

function pushbutton1_Callback(hObject, eventdata, handles)

[filename,filepath] = uigetfile(('*.*'), 'Search image to be displayed');
fullname = [filepath filename] ; 
Image = imread(fullname);
[rows, columns, numberOfColorChannels] = size(Image);
if numberOfColorChannels > 1
    % It's a true color RGB image.  We need to convert to gray scale.
    I = rgb2gray(Image);
else
    % It's already gray scale.  No need to convert.
    I = Image;
end
% I = rgb2gray(Image);
CS = imadjust(I,stretchlim(I),[]);%Contrast Stretching
II = imadjust(CS,[],[],.41);%Increase Intensity
%Binary The Image
BW = imbinarize(I,'adaptive','ForegroundPolarity','dark','Sensitivity',0.4);
results = ocr(BW, 'CharacterSet', 'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ', 'TextLayout','Block');
results.Text
axes(handles.axes1)
imshow(Image);
axis off;
set(handles.text2, 'string', results.Text);