function  task_mitotic_train( hObj )
%MITOTIC_EXPERT Summary of this function goes here
%   Detailed explanation goes here
try
    
    handles = guidata(hObj);
    myData = handles.myData;
    taskinfo = myData.taskinfo;
    calling_function = handles.myData.taskinfo.calling_function;
    
    display([taskinfo.task, ' called from ', calling_function])
%     taskinfo.flagsl=0;
%     taskinfo.flagcb=0;
    switch calling_function
        
        case 'Load_Input_File' % Read in the taskinfo
            
                
            handles = guidata(hObj);
            
            desc = taskinfo.desc;
            
            taskinfo.task  = char(desc{1});
            taskinfo.id = char(desc{2});
            taskinfo.order = str2double(desc{3});
            taskinfo.slot = str2double(desc{4});
            taskinfo.roi_x  = str2double(desc{5});
            taskinfo.roi_y = str2double(desc{6});
            taskinfo.roi_w = str2double(desc{7});
            taskinfo.roi_h = str2double(desc{8});
            taskinfo.img_w = str2double(desc{9});
            taskinfo.img_h = str2double(desc{10});
            taskinfo.text  = 'mitotic_train';
            taskinfo.moveflag = str2double(desc{11});
            taskinfo.zoomflag = str2double(desc{12});
            taskinfo.expertcb1 = char(desc{13});
            taskinfo.expertcb2 = char(desc{14});
            taskinfo.expertcb3 = char(desc{15});
            taskinfo.expertcb4 = char(desc{16});
            taskinfo.expertcb5 = char(desc{17});
            taskinfo.expertcb6 = char(desc{18});
            taskinfo.expertcb7 = char(desc{19});
            taskinfo.expertcb8 = char(desc{20});
            taskinfo.expertsc = char(desc{21});
            taskinfo.checkboxresult=zeros(1,8);            
            
        case {'Update_GUI_Elements', ...
                'ResumeButtonPressed'} % Initialize task elements
            
            % reset checkboxes results
            taskinfo.checkboxresult=zeros(1,8);

            % Load the image
            taskimage_load(hObj);
            handles = guidata(hObj);
            % Show management buttons
            taskmgt_default(handles, 'on');
            handles = guidata(hObj);
            % checkbox
            handles.checkbox1 = uicontrol(...
                'Parent', handles.task_panel, ...
                'FontSize', handles.myData.settings.FontSize, ...
                'Units', 'normalized', ...
                'HorizontalAlignment', 'left', ...
                'ForegroundColor', handles.myData.settings.FG_color, ...
                'BackgroundColor', handles.myData.settings.BG_color, ...
                'Position', [0.1,0.65,0.2,0.1], ...
                'Style', 'checkbox', ...
                'Callback',@checkbox1_Callback, ...
                'String', 'Dark spindle',...
                'TooltipString','Spindle darker (general)');

           
           
           
           handles.checkbox2 = uicontrol(...
                'Parent', handles.task_panel, ...
                'FontSize', handles.myData.settings.FontSize, ...
                'Units', 'normalized', ...
                'HorizontalAlignment', 'left', ...
                'ForegroundColor', handles.myData.settings.FG_color, ...
                'BackgroundColor', handles.myData.settings.BG_color, ...
                'Position', [0.3,0.65,0.2,0.1], ...
                'Style', 'checkbox', ...
                'Callback',@checkbox2_Callback, ...
                'String', 'Ropy texture',...
                'TooltipString','Ropy, hetero. texture (general)');
          
            handles.checkbox3 = uicontrol(...
                'Parent', handles.task_panel, ...
                'FontSize', handles.myData.settings.FontSize, ...
                'Units', 'normalized', ...
                'HorizontalAlignment', 'left', ...
                'ForegroundColor', handles.myData.settings.FG_color, ...
                'BackgroundColor', handles.myData.settings.BG_color, ...
                'Position', [0.5,0.65,0.2,0.1], ...
                'Style', 'checkbox', ...
                'Callback',@checkbox3_Callback, ...
                'String', 'Visible cytoplasm',...
                'TooltipString','Visible cytoplasm (general)');
            
            handles.checkbox4 = uicontrol(...
                'Parent', handles.task_panel, ...
                'FontSize', handles.myData.settings.FontSize, ...
                'Units', 'normalized', ...
                'HorizontalAlignment', 'left', ...
                'ForegroundColor', handles.myData.settings.FG_color, ...
                'BackgroundColor', handles.myData.settings.BG_color, ...
                'Position', [0.7,0.65,0.2,0.1], ...
                'Style', 'checkbox', ...
                'Callback',@checkbox4_Callback, ...
                'String', 'Not apoptotic',...
                'TooltipString','Not apoptotic: brown stain or dissolving, shrinking (general)');
            
            handles.checkbox5 = uicontrol(...
                'Parent', handles.task_panel, ...
                'FontSize', handles.myData.settings.FontSize, ...
                'Units', 'normalized', ...
                'HorizontalAlignment', 'left', ...
                'ForegroundColor', handles.myData.settings.FG_color, ...
                'BackgroundColor', handles.myData.settings.BG_color, ...
                'Position', [0.1,0.45,0.2,0.1], ...
                'Style', 'checkbox', ...
                'Callback',@checkbox5_Callback,...
                'String', 'N/C~2',...
                'TooltipString','Spindle area majority of cell, N/C~2 (prophase)');
            
            
            handles.checkbox6 = uicontrol(...
                'Parent', handles.task_panel, ...
                'FontSize', handles.myData.settings.FontSize, ...
                'Units', 'normalized', ...
                'HorizontalAlignment', 'left', ...
                'ForegroundColor', handles.myData.settings.FG_color, ...
                'BackgroundColor', handles.myData.settings.BG_color, ...
                'Position', [0.3,0.45,0.2,0.1], ...
                'Style', 'checkbox', ...
                'Callback',@checkbox6_Callback,...
                'String', 'Spindle aligned',...
                'TooltipString','Spindle aligned with cell (metaphase)');
            
            
            handles.checkbox7 = uicontrol(...
                'Parent', handles.task_panel, ...
                'FontSize', handles.myData.settings.FontSize, ...
                'Units', 'normalized', ...
                'HorizontalAlignment', 'left', ...
                'ForegroundColor', handles.myData.settings.FG_color, ...
                'BackgroundColor', handles.myData.settings.BG_color, ...
                'Position', [0.5,0.45,0.2,0.1], ...
                'Style', 'checkbox', ...
                'Callback',@checkbox7_Callback,...
                'String', 'Two spindles',...
                'TooltipString','Two spindles have formed (anaphase)');
            
            
            
            handles.checkbox8 = uicontrol(...
                'Parent', handles.task_panel, ...
                'FontSize', handles.myData.settings.FontSize, ...
                'Units', 'normalized', ...
                'HorizontalAlignment', 'left', ...
                'ForegroundColor', handles.myData.settings.FG_color, ...
                'BackgroundColor', handles.myData.settings.BG_color, ...
                'Position', [0.7,0.45,0.2,0.1], .....
                'Style', 'checkbox', ...
                'Callback',@checkbox8_Callback,...
                'String', 'Two membranes',...
                'TooltipString','Two cell membranes visible (telophase)');

            
            % slider  
            initvalue = 50;
            slider_x = .1;
            slider_y = .1;
            slider_w = .6;
            slider_h = .2;
            position = [slider_x, slider_y, slider_w, slider_h];
            handles.slider = uicontrol(...
                'Parent', handles.task_panel, ...
                'FontSize', handles.myData.settings.FontSize, ...
                'Units', 'normalized', ...
                'HorizontalAlignment', 'center', ...
                'ForegroundColor', handles.myData.settings.FG_color, ...
                'BackgroundColor', [.95, .95, .95], ...
                'Position', position, ...
                'Style', 'slider', ...
                'Tag', 'slider', ...
                'String', 'Probability being mitosis', ...
                'Min', 0, ...
                'Max', 100, ...
                'SliderStep', [1.0/100.0, .1], ...
                'Value', initvalue, ...
                'Callback', @slider_Callback);

            position = [slider_x+slider_w+.05, slider_y, .1, .2];
            handles.editvalue = uicontrol(...
                'Parent', handles.task_panel, ...
                'FontSize', handles.myData.settings.FontSize, ...
                'Units', 'normalized', ...
                'HorizontalAlignment', 'center', ...
                'ForegroundColor', handles.myData.settings.FG_color, ...
                'BackgroundColor', [.95, .95, .95], ...
                'Position', position, ...
                'Style', 'edit', ...
                'Tag', 'editvalue', ...
                'String', num2str(initvalue), ...
                'KeyPressFcn', @editvalue_KeyPressFcn, ...
                'Callback', @editvalue_Callback);

           
            
            position = [slider_x, slider_y+slider_h, .1, .1];
            handles.textleft = uicontrol(...
                'Parent', handles.task_panel, ...
                'FontSize', handles.myData.settings.FontSize, ...
                'Units', 'normalized', ...
                'HorizontalAlignment', 'center', ...
                'ForegroundColor', handles.myData.settings.FG_color, ...
                'BackgroundColor', handles.myData.settings.BG_color, ...
                'Position', position, ...
                'Style', 'text', ...
                'Tag', 'textleft', ...
                'String', '0');

            position = [slider_x+slider_w/2-.05, slider_y+slider_h, .1, .1];
            handles.textcenter = uicontrol(...
                'Parent', handles.task_panel, ...
                'FontSize', handles.myData.settings.FontSize, ...
                'Units', 'normalized', ...
                'HorizontalAlignment', 'center', ...
                'ForegroundColor', handles.myData.settings.FG_color, ...
                'BackgroundColor', handles.myData.settings.BG_color, ...
                'Position', position, ...
                'Style', 'text', ...
                'Tag', 'textcenter', ...
                'String', '50');

            position = [slider_x+slider_w-.1, slider_y+slider_h, .1, .1];
            handles.textright = uicontrol(...
                'Parent', handles.task_panel, ...
                'FontSize', handles.myData.settings.FontSize, ...
                'Units', 'normalized', ...
                'HorizontalAlignment', 'center', ...
                'ForegroundColor', handles.myData.settings.FG_color, ...
                'BackgroundColor', handles.myData.settings.BG_color, ...
                'Position', position, ...
                'Style', 'text', ...
                'Tag', 'textright', ...
                'String', '100');

            position = [slider_x+slider_w+.05, slider_y+slider_h, .1, .1];
            handles.textscore = uicontrol(...
                'Parent', handles.task_panel, ...
                'FontSize', handles.myData.settings.FontSize, ...
                'Units', 'normalized', ...
                'HorizontalAlignment', 'center', ...
                'ForegroundColor', handles.myData.settings.FG_color, ...
                'BackgroundColor', handles.myData.settings.BG_color, ...
                'Position', position, ...
                'Style', 'text', ...
                'Tag', 'textright', ...
                'String', 'Score');
            
           uicontrol(handles.editvalue);
            
            position = [0.85, 0.8, .15, .2];
            handles.expert_result = uicontrol(...
                'Parent', handles.task_panel, ...
                'FontSize', handles.myData.settings.FontSize, ...
                'Units', 'normalized', ...
                'ForegroundColor',  handles.myData.settings.FG_color, ...
                'BackgroundColor',  handles.myData.settings.BG_color, ...
                'Position',position, ...
                'Style', 'pushbutton', ...
                'Tag', 'editvalue', ...
                'enable','off',...
                'String', 'expert result',...
                'Callback',@expert_result_Callback);
            
            
          handles.expertsc = uicontrol(...
                'Style', 'text', ...
                'Parent', handles.task_panel, ...
                'FontSize', handles.myData.settings.FontSize, ...
                'Units', 'normalized', ...
                'HorizontalAlignment', 'center', ...
                'Tag', 'textcenter', ...
                'BackgroundColor',  [.95, .95, .95], ...
                'Position', [.85, .15, .1, .1], ...
                'visible','off',...
                'Tag', 'editvalue', ...
                'String', str2num(taskinfo.expertsc));
          handles.texthighlight = uicontrol(...
                  'Style', 'text', ...
                  'Parent', handles.task_panel, ...
                  'FontSize', handles.myData.settings.FontSize, ...
                  'Units', 'normalized', ...
                  'HorizontalAlignment', 'center', ...
                  'ForegroundColor', handles.myData.settings.FG_color, ...
                  'BackgroundColor', handles.myData.settings.BG_color, ...
                  'Position', [0.35,0.9,0.5,0.1], ...
                  'visible','off',...
                  'Tag', 'textcenter', ...
                  'String', 'Red Highlight: input differs from reference.');
            

            
        case {'NextButtonPressed', ...
                'PauseButtonPressed',...
                'Backbutton_Callback'} % Clean up the task elements
            taskmgt_default(handles, 'off');
            handles = guidata(hObj);
            % Hide image and management buttons
            set(handles.iH,'visible','off');
            set(handles.ImageAxes,'visible','off');
            delete(handles.slider);
            delete(handles.editvalue);
            delete(handles.textleft);
            delete(handles.textcenter);
            delete(handles.textright);
            delete(handles.textscore);
            delete(handles.expertsc);
            delete(handles.texthighlight);
                
            handles = rmfield(handles, 'slider');
            handles = rmfield(handles, 'editvalue');
            handles = rmfield(handles, 'textleft');
            handles = rmfield(handles, 'textcenter');
            handles = rmfield(handles, 'textright');
            handles = rmfield(handles, 'textscore');
            handles = rmfield(handles, 'texthighlight');
            handles = rmfield(handles, 'expertsc');

            
            
            
            delete( handles.checkbox1);
            delete( handles.checkbox2);
            delete( handles.checkbox3);
            delete( handles.checkbox4);
            delete( handles.checkbox5);
            delete( handles.checkbox6);
            delete( handles.checkbox7);
            delete( handles.checkbox8);
            handles = rmfield(handles, 'checkbox1');
            handles = rmfield(handles, 'checkbox2');
            handles = rmfield(handles, 'checkbox3');
            handles = rmfield(handles, 'checkbox4');
            handles = rmfield(handles, 'checkbox5');
            handles = rmfield(handles, 'checkbox6');
            handles = rmfield(handles, 'checkbox7');
            handles = rmfield(handles, 'checkbox8');
            delete (handles.expert_result);
            handles =rmfield(handles, 'expert_result');
            
            taskimage_archive(handles);

        case 'Save_Results' % Save the results for this task
%             templarge=length(taskinfo.checkboxresult);
%             taskinfo.checkboxresult= padarray(taskinfo.checkboxresult,[0,8- templarge],'post');
            fprintf(taskinfo.fid, [...
                taskinfo.task, ',', ...
                taskinfo.id, ',', ...
                num2str(taskinfo.order), ',', ...
                num2str(taskinfo.slot), ',',...
                num2str(taskinfo.roi_x), ',',...
                num2str(taskinfo.roi_y), ',', ...
                num2str(taskinfo.roi_w), ',', ...
                num2str(taskinfo.roi_h), ',', ...
                num2str(taskinfo.img_w), ',', ...
                num2str(taskinfo.img_h), ',', ...
                taskinfo.text, ',', ...
                num2str(taskinfo.moveflag), ',', ...
                num2str(taskinfo.zoomflag), ',', ...
                num2str(taskinfo.duration), ',', ...
                num2str(taskinfo.checkboxresult(1)),',',...
                num2str(taskinfo.checkboxresult(2)),',',...
                num2str(taskinfo.checkboxresult(3)),',',...
                num2str(taskinfo.checkboxresult(4)),',',...
                num2str(taskinfo.checkboxresult(5)),',',...
                num2str(taskinfo.checkboxresult(6)),',',...
                num2str(taskinfo.checkboxresult(7)),',',...
                num2str(taskinfo.checkboxresult(8)),',',...
                num2str(taskinfo.score)]);
                fprintf(taskinfo.fid,'\r\n');
            
    end

    % Update handles.myData.taskinfo and pack
    myData.taskinfo = taskinfo;
    handles.myData = myData;
    guidata(hObj, handles);
catch ME
    error_show(ME)
end
end

function checkbox1_Callback(hObj, eventdata)
try
    
    handles = guidata(findobj('Tag','GUI'));
    taskinfo = handles.myData.tasks_out{handles.myData.iter};

% taskinfo.button_desc = get(eventdata.NewValue, 'Tag');

if (get(hObj,'Value') == get(hObj,'Max'))
	taskinfo.checkboxresult(1)=1;
else
	taskinfo.checkboxresult(1)=0;
end
% taskinfo.flagcb=1;
% if taskinfo.flagsl==1
%     set(handles.expert_result,'Enable','on');
% end
    % Pack the results
    handles.myData.tasks_out{handles.myData.iter} = taskinfo;
    guidata(handles.GUI, handles);

catch ME
    error_show(ME)
end
end

function checkbox2_Callback(hObj, eventdata)
try
    
    handles = guidata(findobj('Tag','GUI'));
    taskinfo = handles.myData.tasks_out{handles.myData.iter};

% taskinfo.button_desc = get(eventdata.NewValue, 'Tag');

if (get(hObj,'Value') == get(hObj,'Max'))
	taskinfo.checkboxresult(2)=1;
else
	taskinfo.checkboxresult(2)=0;
end
    % Pack the results
    handles.myData.tasks_out{handles.myData.iter} = taskinfo;
    guidata(handles.GUI, handles);

catch ME
    error_show(ME)
end
end

function checkbox3_Callback(hObj, eventdata)
try
    
    handles = guidata(findobj('Tag','GUI'));
    taskinfo = handles.myData.tasks_out{handles.myData.iter};

% taskinfo.button_desc = get(eventdata.NewValue, 'Tag');

if (get(hObj,'Value') == get(hObj,'Max'))
	taskinfo.checkboxresult(3)=1;
else
	taskinfo.checkboxresult(3)=0;
end
    % Pack the results
    handles.myData.tasks_out{handles.myData.iter} = taskinfo;
    guidata(handles.GUI, handles);

catch ME
    error_show(ME)
end
end



function checkbox4_Callback(hObj, eventdata)
try
    
    handles = guidata(findobj('Tag','GUI'));
    taskinfo = handles.myData.tasks_out{handles.myData.iter};

% taskinfo.button_desc = get(eventdata.NewValue, 'Tag');

if (get(hObj,'Value') == get(hObj,'Max'))
	taskinfo.checkboxresult(4)=1;
else
	taskinfo.checkboxresult(4)=0;
end
    % Pack the results
    handles.myData.tasks_out{handles.myData.iter} = taskinfo;
    guidata(handles.GUI, handles);

catch ME
    error_show(ME)
end
end

function checkbox5_Callback(hObj, eventdata)
try
    
    handles = guidata(findobj('Tag','GUI'));
    taskinfo = handles.myData.tasks_out{handles.myData.iter};

% taskinfo.button_desc = get(eventdata.NewValue, 'Tag');

if (get(hObj,'Value') == get(hObj,'Max'))
	taskinfo.checkboxresult(5)=1;
else
	taskinfo.checkboxresult(5)=0;
end
    % Pack the results
    handles.myData.tasks_out{handles.myData.iter} = taskinfo;
    guidata(handles.GUI, handles);

catch ME
    error_show(ME)
end
end

function checkbox6_Callback(hObj, eventdata)
try
    
    handles = guidata(findobj('Tag','GUI'));
    taskinfo = handles.myData.tasks_out{handles.myData.iter};

% taskinfo.button_desc = get(eventdata.NewValue, 'Tag');

if (get(hObj,'Value') == get(hObj,'Max'))
	taskinfo.checkboxresult(6)=1;
else
	taskinfo.checkboxresult(6)=0;
end
    % Pack the results
    handles.myData.tasks_out{handles.myData.iter} = taskinfo;
    guidata(handles.GUI, handles);

catch ME
    error_show(ME)
end
end

function checkbox7_Callback(hObj, eventdata)
try
    
    handles = guidata(findobj('Tag','GUI'));
    taskinfo = handles.myData.tasks_out{handles.myData.iter};

% taskinfo.button_desc = get(eventdata.NewValue, 'Tag');

if (get(hObj,'Value') == get(hObj,'Max'))
	taskinfo.checkboxresult(7)=1;
else
	taskinfo.checkboxresult(7)=0;
end
    % Pack the results
    handles.myData.tasks_out{handles.myData.iter} = taskinfo;
    guidata(handles.GUI, handles);

catch ME
    error_show(ME)
end
end

function checkbox8_Callback(hObj, eventdata)
try
    
    handles = guidata(findobj('Tag','GUI'));
    taskinfo = handles.myData.tasks_out{handles.myData.iter};

% taskinfo.button_desc = get(eventdata.NewValue, 'Tag');

if (get(hObj,'Value') == get(hObj,'Max'))
	taskinfo.checkboxresult(8)=1;
else
	taskinfo.checkboxresult(8)=0;
end
    % Pack the results
    handles.myData.tasks_out{handles.myData.iter} = taskinfo;
    guidata(handles.GUI, handles);

catch ME
    error_show(ME)
end
end


function slider_Callback(hObj, eventdata)
try
    
    handles = guidata(findobj('Tag','GUI'));
    taskinfo = handles.myData.tasks_out{handles.myData.iter};

    set(handles.slider, 'BackgroundColor', [.95, .95, .95]);
%     taskinfo.flagsl=1;
%     if taskinfo.flagcb==1
%         set(handles.expert_result,'Enable','on');
%    end
     set(handles.expert_result,'Enable','on');
    score = round(get(hObj, 'Value'));
    set(handles.editvalue, 'String', num2str(score));

    taskinfo.score = score;
    handles.myData.tasks_out{handles.myData.iter} = taskinfo;
    guidata(handles.GUI, handles);
    
catch ME
    error_show(ME)
end

end

function editvalue_KeyPressFcn(hObj, eventdata)
try
    %--------------------------------------------------------------------------
    % When the text box is non-empty, the user can continue
    %--------------------------------------------------------------------------
    handles = guidata(findobj('Tag','GUI'));
    editvalue_string = eventdata.Key;
    taskinfo = handles.myData.tasks_out{handles.myData.iter};

    set(handles.slider, ...
        'BackgroundColor', handles.myData.settings.BG_color);

    desc_digits = {'0', '1', '2', '3', '4', '5', '6', '7', '8', '9', ...
        'delete', 'return', 'backspace'};
    test = max(strcmp(editvalue_string, desc_digits));
    if test
%        taskinfo.flagsl=1;
%            if taskinfo.flagcb==1
%                set(handles.expert_result,'Enable','on');
%            end
        set(handles.expert_result,'Enable','on');
    else
        desc = 'Input should be an integer';
        h_errordlg = errordlg(desc,'Application error','modal');
        uiwait(h_errordlg)

        score = round(get(hObj, 'Value'));
        set(handles.editvalue, 'String', num2str(score));
        taskinfo.flagsl=0;
        set(handles.expert_result,'Enable','off');
        uicontrol(handles.editvalue);

        return
    end

catch ME
    error_show(ME)
end

end


function editvalue_Callback(hObj, eventdata)
    handles = guidata(findobj('Tag','GUI'));
    taskinfo = handles.myData.tasks_out{handles.myData.iter};

    score = str2double(get(handles.editvalue, 'String'));

    if score > 100
        score = 100;
        set(handles.editvalue, 'String', '100');
        set(handles.slider, 'Value', 100);
    elseif score < 0
        score = 0;
        set(handles.editvalue, 'String', '0');
        set(handles.slider, 'Value', 0);
    end
    
    set(handles.slider, ...
        'BackgroundColor', [.95, .95, .95], ...
        'Value', score);
%     taskinfo.flagsl=1;
%         if taskinfo.flagcb==1
%             set(handles.expert_result,'Enable','on');
%         end
    set(handles.expert_result,'Enable','on');
    uicontrol(handles.expert_result);
    
    % Pack the results
    taskinfo.score = score;
    handles.myData.tasks_out{handles.myData.iter} = taskinfo;
    guidata(handles.GUI, handles);
    
end


function expert_result_Callback(hObj, eventdata) %#ok<DEFNU>
try
     handles = guidata(findobj('Tag','GUI'));     
     taskinfo = handles.myData.tasks_out{handles.myData.iter};
     set(handles.checkbox1,'Enable','inactive');
     set(handles.checkbox2,'Enable','inactive');
     set(handles.checkbox3,'Enable','inactive');
     set(handles.checkbox4,'Enable','inactive');
     set(handles.checkbox5,'Enable','inactive');
     set(handles.checkbox6,'Enable','inactive');
     set(handles.checkbox7,'Enable','inactive');
     set(handles.checkbox8,'Enable','inactive');
     set(handles.slider,'Enable','inactive');
     set(handles.editvalue,'Enable','inactive');
     if str2num(taskinfo.expertcb1) ~= taskinfo.checkboxresult(1)
          set(handles.checkbox1,'BackgroundColor', [.5, .0, .0]);
     end
     if str2num(taskinfo.expertcb2) ~= taskinfo.checkboxresult(2)
          set(handles.checkbox2,'BackgroundColor', [.5, .0, .0]);
     end
     if str2num(taskinfo.expertcb3) ~= taskinfo.checkboxresult(3)
          set(handles.checkbox3,'BackgroundColor', [.5, .0, .0]);
     end
     if str2num(taskinfo.expertcb4) ~= taskinfo.checkboxresult(4)
          set(handles.checkbox4,'BackgroundColor', [.5, .0, .0]);
     end
     if str2num(taskinfo.expertcb5) ~= taskinfo.checkboxresult(5)
          set(handles.checkbox5,'BackgroundColor', [.5, .0, .0]);
     end
     if str2num(taskinfo.expertcb6) ~= taskinfo.checkboxresult(6)
          set(handles.checkbox6,'BackgroundColor', [.5, .0, .0]);
     end
     if str2num(taskinfo.expertcb7) ~= taskinfo.checkboxresult(7)
          set(handles.checkbox7,'BackgroundColor', [.5, .0, .0]);
     end
     if str2num(taskinfo.expertcb8) ~= taskinfo.checkboxresult(8)
          set(handles.checkbox8,'BackgroundColor', [.5, .0, .0]);
     end                

     if str2num(taskinfo.expertsc) ~= taskinfo.score
         set( handles.expertsc,'BackgroundColor', [.5, .0, .0],...
             'visible','on' );        
     end
     set(handles.texthighlight,'visible','on');
     set(handles.NextButton,'Enable','on');
     set(handles.expert_result,'Enable','off');
     uicontrol(handles.NextButton);
     handles.myData.tasks_out{handles.myData.iter} = taskinfo;
     guidata(handles.GUI, handles);
catch ME
    error_show(ME)
end
end





