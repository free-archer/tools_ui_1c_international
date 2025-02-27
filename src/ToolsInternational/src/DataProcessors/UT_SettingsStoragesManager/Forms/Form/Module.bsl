#Region FormEventHandlers

&AtServer
Procedure OnCreateAtServer(Cancel, StandardProcessing)

	ОтборПоХранилищамНастроек.Add("FormDataSettingsStorage", NStr("ru = 'Хранилище настроек данных форм'"));
	ОтборПоХранилищамНастроек.Add("CommonSettingsStorage", NStr("ru = 'Хранилище общих настроек'"));
	ОтборПоХранилищамНастроек.Add("DynamicListsUserSettingsStorage", NStr(
		"ru = 'Хранилище пользовательских настроек динамических списков'"));
	ОтборПоХранилищамНастроек.Add("ReportsUserSettingsStorage", NStr(
		"ru = 'Хранилище пользовательских настроек отчетов'"));
	ОтборПоХранилищамНастроек.Add("SystemSettingsStorage", NStr("ru = 'Хранилище системных настроек'"));

	ОбновитьТаблицуПользователей();
	
	UT_Common.ToolFormOnCreateAtServer(ThisObject, Cancel, StandardProcessing);

EndProcedure

&AtClient
Procedure OnOpen(Cancel)
		
	// Начальное заполнение дерева настроек
	ОбновитьНастройкиВладельца(Undefined);
	
	// Управление внешним видом формы
	ОбновитьОтображениеЭлементов();

	Items.ТаблицаВыбранныхНастроек.RowFilter = New FixedStructure("Check", True);

EndProcedure

&AtClient
Procedure ОбновитьНастройкиВладельца(Command)

	ОбновитьНастройкиВладельцаНаСервере();

	Items.ДеревоКонфигурации.Expand(
		ДеревоКонфигурации.GetItems()[0].GetID());

EndProcedure

&AtClient
Procedure ВариантПредставленияОбъектовКонфигурацииПриИзменении(Item)

	ОбновитьОтображениеЭлементов(Item.Name);

	ОбновитьНастройкиВладельца(Undefined);

EndProcedure

&AtClient
Procedure ДеревоКонфигурацииПометкаПриИзменении(Item)

	ТекДанные = Items.ДеревоКонфигурации.CurrentData;
	УправлениеПометками(ТекДанные);

EndProcedure

&AtClient
Procedure ДеревоКонфигурацииПриАктивизацииСтроки(Item)

	ТекДанные = Items.ДеревоКонфигурации.CurrentData;
	If ТекДанные = Undefined Then
		Return;
	EndIf;

	Items.ТаблицаНастроек.RowFilter = ?(ТекДанные.ИдентификаторОтбора = 0, Undefined,
		New FixedStructure("ИдентификаторОтбора" + ТекДанные.Level, ТекДанные.ИдентификаторОтбора));

EndProcedure

&AtClient
Procedure ОтменитьВыборНастройки(Command)

	For Each ВыделеннаяСтрока In Items.ТаблицаВыбранныхНастроек.SelectedRows Do

		String = ТаблицаНастроек.FindByID(ВыделеннаяСтрока);
		If String <> Undefined Then
			String.Check = False;
		EndIf;

	EndDo;

EndProcedure

&AtClient
Procedure ТаблицаНастроекПометкаПриИзменении(Item)

	СтрокаДерева = Items.ДеревоКонфигурации.CurrentData;
	If СтрокаДерева = Undefined Then
		Return;
	EndIf;

	ПараметрыОтбора = New Structure;
	ПараметрыОтбора.Insert("ИдентификаторОтбора" + СтрокаДерева.Level, СтрокаДерева.ИдентификаторОтбора);
	НайденныеСтроки = ТаблицаНастроек.FindRows(ПараметрыОтбора);
	If НайденныеСтроки <> Undefined Then
		ВсегоНастроек = НайденныеСтроки.Count();
	EndIf;

	ПараметрыОтбора.Insert("Check", True);
	НайденныеСтроки = ТаблицаНастроек.FindRows(ПараметрыОтбора);
	If НайденныеСтроки <> Undefined Then
		КолПометок = НайденныеСтроки.Count();
	EndIf;

	If КолПометок = 0 Then
		СтрокаДерева.Check = 0;
	ElsIf КолПометок <> ВсегоНастроек Then
		СтрокаДерева.Check = 2;
	Else
		СтрокаДерева.Check = 1;
	EndIf;

	УправлениеПометками(СтрокаДерева, False);

EndProcedure

&AtClient
Procedure ТаблицаНастроекНастройкиОткрытие(Item, StandardProcessing)

	StandardProcessing = False;

	ТекДанные = Items.ТаблицаНастроек.CurrentData;
	If ТекДанные = Undefined Then
		Return;
	EndIf;

	ПросмотрНастроекНаСервере(ТекДанные.ИмяХранилищаНастроек, ТекДанные.ObjectKey, ТекДанные.SettingsKey,
		ВладелецНастроек);

EndProcedure

&AtClient
Procedure ПоказатьВыбранныеНастройки(Command)
	Items.ДеревоКонфигурацииПоказатьВыбранныеНастройки.Check = Not Items.ДеревоКонфигурацииПоказатьВыбранныеНастройки.Check;
	ОбновитьОтображениеЭлементов("ПоказатьВыбранныеНастройки");
EndProcedure

&AtClient
Procedure ВладелецНастроекПриИзменении(Item)
	ОбновитьНастройкиВладельца(Undefined);
EndProcedure

&AtClient
Procedure ВладелецНастроекОчистка(Item, StandardProcessing)
	ОбновитьНастройкиВладельца(Undefined);
EndProcedure

&AtClient
Procedure ПоказатьВыбранныхПользователей(Command)
	Items.ТаблицаПользователиПоказатьВыбранныхПользователей.Check = Not Items.ТаблицаПользователиПоказатьВыбранныхПользователей.Check;
	ОбновитьОтображениеЭлементов("ПоказатьВыбранныхПользователей");
EndProcedure

&AtClient
Procedure ТаблицаПользователиПометкаПриИзменении(Item)

	ТекДанные = Items.Users.CurrentData;
	If ТекДанные = Undefined Then
		Return;
	EndIf;

	If ТекДанные.Check Then
		ТекДанные.Check = False;
	EndIf;

EndProcedure

&AtClient
Procedure УдалитьВыбранныеНастройки(Command)
	
	// Проверки
	ЕстьОшибка = False;
	Filter = New Structure("Check", True);
	НайденныеСтроки = ТаблицаНастроек.FindRows(Filter);
	If НайденныеСтроки.Count() = 0 Then
		UT_CommonClientServer.MessageToUser(NStr("ru = 'Not выбраны настройки для удаления'"), , , ,
			ЕстьОшибка);
	EndIf;

	If ЕстьОшибка Then
		Return;
	EndIf;

	ShowQueryBox(
		New NotifyDescription("ВопросУдалитьНастройкиЗавершение", ThisForm), StrTemplate(NStr(
		"ru = 'Delete выбранные настройки у пользователя %1?'"), ВладелецНастроек), QuestionDialogMode.YesNo, ,
		DialogReturnCode.None, NStr("ru = 'Attention!'"));

EndProcedure

&AtClient
Procedure СкопироватьВыбранныеНастройки(Command)
	
	// Проверки
	ЕстьОшибка = False;
	Filter = New Structure("Check", True);
	НайденныеСтроки = ТаблицаНастроек.FindRows(Filter);
	If НайденныеСтроки.Count() = 0 Then
		UT_CommonClientServer.MessageToUser(NStr("ru = 'Not выбраны настройки для копирования'"), , , ,
			ЕстьОшибка);
	EndIf;
	НайденныеСтроки = Users.FindRows(Filter);
	If НайденныеСтроки.Count() = 0 Then
		UT_CommonClientServer.MessageToUser(NStr("ru = 'Not указаны пользователи (кому копировать)'"),
			, , , ЕстьОшибка);
	EndIf;

	If ЕстьОшибка Then
		Return;
	EndIf;

	ShowQueryBox(
		New NotifyDescription("ВопросСкопироватьНастройкиЗавершение", ThisForm), NStr(
		"ru = 'Copy выбранные настройки выбранным пользователям?'"), QuestionDialogMode.YesNo, ,
		DialogReturnCode.None, NStr("ru = 'Attention!'"));

EndProcedure

&AtClient
Procedure ТекстОтбораПоХранилищамНастроекНачалоВыбора(Item, ДанныеВыбора, StandardProcessing)
	StandardProcessing = False;
	ОтборПоХранилищамНастроек.ShowCheckItems(
		New NotifyDescription("ИзменениеОтбораПоХранилищамНастроекЗавершение", ThisForm));
EndProcedure

&AtClient
Procedure ТекстОтбораПоХранилищамНастроекОчистка(Item, StandardProcessing)
	StandardProcessing = False;
	ТекстОтбораПоХранилищамНастроек = "";
	ОтборПоХранилищамНастроек.FillChecks(False);
EndProcedure

//@skip-warning
&AtClient
Procedure Attachable_ExecuteToolsCommonCommand(Command) 
	UT_CommonClient.Attachable_ExecuteToolsCommonCommand(ThisObject, Command);
EndProcedure



#EndRegion

/////////////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////////

#Region ОбработкиЗавершения

&AtClient
Procedure ВопросУдалитьНастройкиЗавершение(РезультатВопроса, AdditionalParameters) Export

	If РезультатВопроса = DialogReturnCode.None Then
		Return;
	EndIf;

	УдалитьВыбранныеНастройкиНаСервере();

	ОбновитьНастройкиВладельца(Undefined);

EndProcedure

&AtClient
Procedure ВопросСкопироватьНастройкиЗавершение(РезультатВопроса, AdditionalParameters) Export

	If РезультатВопроса = DialogReturnCode.None Then
		Return;
	EndIf;

	СкопироватьВыбранныеНастройкиНаСервере();

	ShowMessageBox( , NStr("ru = 'Copy настроек выполнено'"));

EndProcedure

&AtClient
Procedure ИзменениеОтбораПоХранилищамНастроекЗавершение(List, AdditionalParameters) Export

	If List = Undefined Then
		Return;
	EndIf;

	ТекстОтбораПоХранилищамНастроек = "";
	For Each ЭлементСписка In List Do
		If ЭлементСписка.Check Then
			ТекстОтбораПоХранилищамНастроек = ТекстОтбораПоХранилищамНастроек + ?(ТекстОтбораПоХранилищамНастроек = "",
				"", "; ") + ЭлементСписка.Presentation;
		EndIf;
	EndDo;

	ОбновитьНастройкиВладельца(Undefined);

EndProcedure

#EndRegion

/////////////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////////

#Region Private

&AtServer
Procedure ОбновитьТаблицуПользователей()

	Users.Clear();

	ПользователиИБ=InfoBaseUsers.GetUsers();
	For Each ПользовательИБ In ПользователиИБ Do
		НС=Users.Add();
		НС.Name=ПользовательИБ.Name;
		НС.FullName=ПользовательИБ.FullName;
		НС.Picture=0;
		НС.UUID=ПользовательИБ.UUID;

	EndDo;

EndProcedure

&AtClient
Procedure ОбновитьОтображениеЭлементов(ЭлементыУправления = Undefined)

	// Подготовить массив имен ЭУ, отображение которых надо обновить
	МассивЭУ = New Array;
	If TypeOf(ЭлементыУправления) = Type("String") Then
		МассивЭУ = StrSplit(ЭлементыУправления, ",");
	EndIf;

	If МассивЭУ.Count() = 0 Or МассивЭУ.Find("ВариантПредставленияОбъектовКонфигурации") <> Undefined Then
		Items.ДеревоКонфигурацииПоИмени.Visible = (ВариантПредставленияОбъектовКонфигурации = 0);
		Items.ДеревоКонфигурацииПоСинониму.Visible = (ВариантПредставленияОбъектовКонфигурации = 1);
	EndIf;

	If МассивЭУ.Count() = 0 Or МассивЭУ.Find("ПоказатьВыбранныеНастройки") <> Undefined Then
		Items.ГруппаВыбранныеНастройки.Visible = Items.ДеревоКонфигурацииПоказатьВыбранныеНастройки.Check;
		Items.ДеревоКонфигурацииПоказатьВыбранныеНастройки.Title = ?(Items.ГруппаВыбранныеНастройки.Visible,
			NStr("ru = 'Hide выбранные настройки'"), NStr("ru = 'Show выбранные настройки'"));
	EndIf;

	If МассивЭУ.Count() = 0 Or МассивЭУ.Find("ПоказатьВыбранныхПользователей") <> Undefined Then
		Items.Users.RowFilter = ?(Items.ТаблицаПользователиПоказатьВыбранныхПользователей.Check,
			New FixedStructure("Check", True), Undefined);
		Items.ТаблицаПользователиПоказатьВыбранныхПользователей.Title = ?(
			Items.Users.RowFilter <> Undefined, NStr("ru = 'Show всех'"), NStr(
			"ru = 'Show выбранных'"));
	EndIf;	
	
	//If МассивЭУ.Count() = 0 Then
	// В условии описываюся свойства элементов,
	// которые обновляются независимо от переданного параметра ЭлементыУправления
	//EndIf;

EndProcedure

&AtServer
Procedure ОбновитьНастройкиВладельцаНаСервере()

	// Инициализитовать дерево конфигурации и очистить его
	ДЗ = FormAttributeToValue("ДеревоКонфигурации");
	ДЗ.Rows.Clear();
	// Инициализитовать таблицу настроек и очистить его
	ТЗ = FormAttributeToValue("ТаблицаНастроек");
	ТЗ.Clear();
	
	// Create строку для корня конфигурации
	СтрокаДереваКонфигурация = ДЗ.Rows.Add();
	СтрокаДереваКонфигурация.ПредставлениеИмя = Metadata.Name + NStr("ru = ' (All настройки)'");
	СтрокаДереваКонфигурация.ПредставлениеСиноним = Metadata.Synonym + NStr("ru = ' (All настройки)'");
	СтрокаДереваКонфигурация.Order = 0;
	//СтрокаДереваКонфигурация.Picture = 0;
	СтрокаДереваПрочее = СтрокаДереваКонфигурация.Rows.Add();
	СтрокаДереваПрочее.ПредставлениеИмя = NStr("ru = 'Прочее'");
	СтрокаДереваПрочее.ПредставлениеСиноним = СтрокаДереваПрочее.ПредставлениеИмя;
	СтрокаДереваПрочее.Order = 900;
	СтрокаДереваПрочее.Path = "Прочее";
	СтрокаДереваПрочее.ИдентификаторОтбора = 1;
	//СтрокаДереваПрочее.Picture = 0;
	
	// Parameters для создания веток дерева
	AdditionalParameters = ИнициализироватьПараметрыДляСозданияДереваКонфигурации(ТЗ);
	AdditionalParameters.Insert("СтрокаДереваКонфигурация", СтрокаДереваКонфигурация);
	AdditionalParameters.Insert("СтрокаДереваПрочее", СтрокаДереваПрочее);
	
	// Get настроки пользователя
	Filter = New Structure("User", ВладелецНастроек);
	For Each ЭлементСписка In ОтборПоХранилищамНастроек Do
		If ЭлементСписка.Check Or IsBlankString(ТекстОтбораПоХранилищамНастроек) Then

			ИмяХранилищаНастроек = ЭлементСписка.Value;
			Выборка = Eval(ИмяХранилищаНастроек).StartChoosing(Filter);
			AdditionalParameters.ИмяХранилищаНастроек = ИмяХранилищаНастроек;
				
				// FillType дерева
			ДополнитьДеревоНастроек(Выборка, ИмяХранилищаНастроек, AdditionalParameters);

		EndIf;
	EndDo; 
		
	// Send значения на форму
	ValueToFormAttribute(ДЗ, "ДеревоКонфигурации");
	ValueToFormAttribute(AdditionalParameters.ТаблицаЗначенийНастроек, "ТаблицаНастроек");

EndProcedure

&AtServer
Procedure ДополнитьДеревоНастроек(Выборка, ИмяХранилищаНастроек, AdditionalParameters)

	СтрокаДереваКонфигурация = AdditionalParameters.СтрокаДереваКонфигурация;
	СтрокаДереваПрочее = AdditionalParameters.СтрокаДереваПрочее;
	
	// Do по настройкам пользователя
	While Выборка.Next() Do
		
		// Разложить ObjectKey в Array(10)
		МассивКлюч = StrSplit(Выборка.ObjectKey, "/", True);
		КоличествоЭлементовВМассиве = МассивКлюч.Count();
		For Ин = КоличествоЭлементовВМассиве To 9 Do
			МассивКлюч.Add("");
		EndDo;
		
		// Разложить Key объекта настроек в Array(10)
		ПутьОбъектаКонфигурации = ?(МассивКлюч[0] = "Общее" And МассивКлюч[1] = "TableSearchHistory", МассивКлюч[2],
			МассивКлюч[0]);
		МассивПуть = StrSplit(ПутьОбъектаКонфигурации, ".", True);
		КоличествоЭлементовВМассиве = МассивПуть.Count();
		For Ин = КоличествоЭлементовВМассиве To 9 Do
			МассивПуть.Add("");
		EndDo;
		
		// Run рекурсивного создания строк дерева настроек
		AdditionalParameters.Insert("СтрокаДереваКонфигурация", СтрокаДереваКонфигурация);
		AdditionalParameters.Insert("МассивПуть", МассивПуть);
		AdditionalParameters.Insert("ВыборкаНастроек", Выборка);
		ПроверяемоеСвойство = StrReplace(МассивПуть[0], " ", "");
		Try
			If AdditionalParameters.ПредопределенныеВеткиКонфигурации.Property(ПроверяемоеСвойство) Then
				СоздатьВеткуКонфигурации(СтрокаДереваКонфигурация, AdditionalParameters);
			Else
				СоздатьВеткуКонфигурации(СтрокаДереваПрочее, AdditionalParameters);
			EndIf;
		Except
		EndTry;
	EndDo;

EndProcedure

&AtServer
Function ИнициализироватьПараметрыДляСозданияДереваКонфигурации(ТаблицаЗначенийНастроек)

	AdditionalParameters = New Structure;
	AdditionalParameters.Insert("ИмяХранилищаНастроек", "");
	AdditionalParameters.Insert("ТаблицаЗначенийНастроек", ТаблицаЗначенийНастроек);
	AdditionalParameters.Insert("НомерКартинки", 0);
	AdditionalParameters.Insert("СчетчикИдентификаторовОтбора", 2);
	AdditionalParameters.Insert("ПредопределенныеВеткиКонфигурации", New Structure);
	AdditionalParameters.ПредопределенныеВеткиКонфигурации.Insert("Общие", "Общие");
	AdditionalParameters.ПредопределенныеВеткиКонфигурации.Insert("Подсистема", "Подсистема");
	AdditionalParameters.ПредопределенныеВеткиКонфигурации.Insert("SettingsStorage", "SettingsStorage");
	AdditionalParameters.ПредопределенныеВеткиКонфигурации.Insert("ExchangePlan", "ExchangePlan");
	AdditionalParameters.ПредопределенныеВеткиКонфигурации.Insert("ОбщаяФорма", "ОбщаяФорма");
	AdditionalParameters.ПредопределенныеВеткиКонфигурации.Insert("Constant", "Constant");
	AdditionalParameters.ПредопределенныеВеткиКонфигурации.Insert("Catalog", "Catalog");
	AdditionalParameters.ПредопределенныеВеткиКонфигурации.Insert("Document", "Document");
	AdditionalParameters.ПредопределенныеВеткиКонфигурации.Insert("DocumentJournal", "DocumentJournal");
	AdditionalParameters.ПредопределенныеВеткиКонфигурации.Insert("Enum", "Enum");
	AdditionalParameters.ПредопределенныеВеткиКонфигурации.Insert("Report", "Report");
	AdditionalParameters.ПредопределенныеВеткиКонфигурации.Insert("ExternalReport", "ExternalReport");
	AdditionalParameters.ПредопределенныеВеткиКонфигурации.Insert("Processing", "Processing");
	AdditionalParameters.ПредопределенныеВеткиКонфигурации.Insert("ExternalDataProcessor", "ExternalDataProcessor");
	AdditionalParameters.ПредопределенныеВеткиКонфигурации.Insert("ChartOfCharacteristicTypes",
		"ChartOfCharacteristicTypes");
	AdditionalParameters.ПредопределенныеВеткиКонфигурации.Insert("ChartOfAccounts", "ChartOfAccounts");
	AdditionalParameters.ПредопределенныеВеткиКонфигурации.Insert("ChartOfCalculationTypes", "ChartOfCalculationTypes");
	AdditionalParameters.ПредопределенныеВеткиКонфигурации.Insert("InformationRegister", "InformationRegister");
	AdditionalParameters.ПредопределенныеВеткиКонфигурации.Insert("AccumulationRegister", "AccumulationRegister");
	AdditionalParameters.ПредопределенныеВеткиКонфигурации.Insert("AccountingRegister", "AccountingRegister");
	AdditionalParameters.ПредопределенныеВеткиКонфигурации.Insert("CalculationRegister", "CalculationRegister");
	AdditionalParameters.ПредопределенныеВеткиКонфигурации.Insert("BusinessProcess", "BusinessProcess");
	AdditionalParameters.ПредопределенныеВеткиКонфигурации.Insert("Task", "Task");
	AdditionalParameters.ПредопределенныеВеткиКонфигурации.Insert("ExternalDataSource", "ExternalDataSource");

	Return AdditionalParameters;

EndFunction

&AtServer
Procedure СоздатьВеткуКонфигурации(СтрокаРодитель, AdditionalParameters, Level = 0)
	
	// Дополнить "Path" настройки, чтобы дерево было похоже на дерево конфигурации в конфигураторе 1С
	If Level = 0 And (AdditionalParameters.МассивПуть[Level] = "ОбщаяФорма"
		Or AdditionalParameters.МассивПуть[Level] = "SettingsStorage"
		Or AdditionalParameters.МассивПуть[Level] = "ExchangePlan" Or AdditionalParameters.МассивПуть[Level]
		= "Подсистема") Then
		AdditionalParameters.МассивПуть.Insert(0, "Общие");
	EndIf; 
	
	// ПутьПоиска, нужен для того, чтобы не дублировалить ветки дерева настроек
	ПутьПоиска = ?(Level = 0, "", СтрокаРодитель.Path + ".") + AdditionalParameters.МассивПуть[Level];
	
	// Find существующую ветку
	СтрокаДерева = СтрокаРодитель.Rows.Find(ПутьПоиска, "Path", False);
	If СтрокаДерева = Undefined Then		
		
		// Not нашли. Create новую ветку
		СтрокаДерева = СтрокаРодитель.Rows.Add();
		СтрокаДерева.Path = ПутьПоиска;
		СтрокаДерева.Level = Level;
		СтрокаДерева.ИдентификаторОтбора = AdditionalParameters.СчетчикИдентификаторовОтбора;
		AdditionalParameters.СчетчикИдентификаторовОтбора = AdditionalParameters.СчетчикИдентификаторовОтбора + 1;
		// Fill колонки строки дерева
		ЗаполнитьСтрокуДереваКонфигурации(СтрокаДерева, AdditionalParameters, Level);

	EndIf;

	If AdditionalParameters.МассивПуть[Level + 1] <> "" And Level < 3 Then
		// Рекурсия
		СоздатьВеткуКонфигурации(СтрокаДерева, AdditionalParameters, Level + 1);

	Else
		// Add строку в таблицу настроек текущей строки дерева
		СтрокаТаблицыНастроек = AdditionalParameters.ТаблицаЗначенийНастроек.Add();
		СтрокаТаблицыНастроек.ИмяХранилищаНастроек = AdditionalParameters.ИмяХранилищаНастроек;
		СтрокаТаблицыНастроек.НастройкиПр = AdditionalParameters.ВыборкаНастроек.Settings;
		FillPropertyValues(СтрокаТаблицыНастроек, AdditionalParameters.ВыборкаНастроек);
		УстановитьИдентификаторОтбора(СтрокаТаблицыНастроек, СтрокаДерева);

	EndIf; 
		
	// Sort уровня дерева взависимости от варианта отображения представления. Либо по имени, либо по синониму
	СтрокаРодитель.Rows.Sort(
		?(ВариантПредставленияОбъектовКонфигурации = 0, "Order, ПредставлениеИмя", "Order, ПредставлениеСиноним"));

EndProcedure

&AtServer
Function ЗаполнитьСтрокуДереваКонфигурации(СтрокаДерева, AdditionalParameters, IndexOf)
	
	// Values по умолчанию
	СтрокаДерева.ПредставлениеИмя = AdditionalParameters.МассивПуть[IndexOf];
	СтрокаДерева.ПредставлениеСиноним = AdditionalParameters.МассивПуть[IndexOf];
	СтрокаДерева.Order = 999;

	If AdditionalParameters.МассивПуть[IndexOf] = AdditionalParameters.ПредопределенныеВеткиКонфигурации.Общие Then
		СтрокаДерева.ПредставлениеИмя = "Общие";
		СтрокаДерева.Order = 10;
		//СтрокаДерева.Picture = 0;

	ElsIf AdditionalParameters.МассивПуть[IndexOf]
		= AdditionalParameters.ПредопределенныеВеткиКонфигурации.Подсистема Then
		СтрокаДерева.ПредставлениеИмя = "Subsystems";
		СтрокаДерева.ПредставлениеСиноним = "Subsystems";
		СтрокаДерева.КлассОбъектовМетаданных = "Подсистема";
		СтрокаДерева.ФормироватьПредставлениеПодчиненныхСтрокИзСинонимаМетаданных = True;
		СтрокаДерева.Order = 20;
		//СтрокаДерева.Picture = 0;

	ElsIf AdditionalParameters.МассивПуть[IndexOf]
		= AdditionalParameters.ПредопределенныеВеткиКонфигурации.SettingsStorage Then
		СтрокаДерева.ПредставлениеИмя = "Хранилища настроек";
		СтрокаДерева.ПредставлениеСиноним = "Хранилища настроек";
		СтрокаДерева.КлассОбъектовМетаданных = "SettingsStorage";
		СтрокаДерева.ФормироватьПредставлениеПодчиненныхСтрокИзСинонимаМетаданных = True;
		СтрокаДерева.Order = 21;
		//СтрокаДерева.Picture = 0;

	ElsIf AdditionalParameters.МассивПуть[IndexOf]
		= AdditionalParameters.ПредопределенныеВеткиКонфигурации.ExchangePlan Then
		СтрокаДерева.ПредставлениеИмя = "Планы обмена";
		СтрокаДерева.ПредставлениеСиноним = "Планы обмена";
		СтрокаДерева.КлассОбъектовМетаданных = "ExchangePlan";
		СтрокаДерева.ФормироватьПредставлениеПодчиненныхСтрокИзСинонимаМетаданных = True;
		СтрокаДерева.Order = 22;
		//СтрокаДерева.Picture = 0;

	ElsIf AdditionalParameters.МассивПуть[IndexOf]
		= AdditionalParameters.ПредопределенныеВеткиКонфигурации.ОбщаяФорма Then
		СтрокаДерева.ПредставлениеИмя = "Общие формы";
		СтрокаДерева.ПредставлениеСиноним = "Общие формы";
		СтрокаДерева.КлассОбъектовМетаданных = "ОбщаяФорма";
		СтрокаДерева.ФормироватьПредставлениеПодчиненныхСтрокИзСинонимаМетаданных = True;
		СтрокаДерева.Order = 23;
		СтрокаДерева.Picture = 1;

	ElsIf AdditionalParameters.МассивПуть[IndexOf]
		= AdditionalParameters.ПредопределенныеВеткиКонфигурации.Constant Then
		СтрокаДерева.ПредставлениеИмя = "Constants";
		СтрокаДерева.ПредставлениеСиноним = "Constants";
		СтрокаДерева.КлассОбъектовМетаданных = "Constant";
		СтрокаДерева.ФормироватьПредставлениеПодчиненныхСтрокИзСинонимаМетаданных = True;
		СтрокаДерева.Order = 30;
		//СтрокаДерева.Picture = 0;

	ElsIf AdditionalParameters.МассивПуть[IndexOf]
		= AdditionalParameters.ПредопределенныеВеткиКонфигурации.Catalog Then
		СтрокаДерева.ПредставлениеИмя = "Catalogs";
		СтрокаДерева.ПредставлениеСиноним = "Catalogs";
		СтрокаДерева.КлассОбъектовМетаданных = "Catalog";
		СтрокаДерева.ФормироватьПредставлениеПодчиненныхСтрокИзСинонимаМетаданных = True;
		СтрокаДерева.Order = 31;
		СтрокаДерева.Picture = 2;

	ElsIf AdditionalParameters.МассивПуть[IndexOf]
		= AdditionalParameters.ПредопределенныеВеткиКонфигурации.Document Then
		СтрокаДерева.ПредставлениеИмя = "Documents";
		СтрокаДерева.ПредставлениеСиноним = "Documents";
		СтрокаДерева.КлассОбъектовМетаданных = "Document";
		СтрокаДерева.ФормироватьПредставлениеПодчиненныхСтрокИзСинонимаМетаданных = True;
		СтрокаДерева.Order = 32;
		СтрокаДерева.Picture = 3;

	ElsIf AdditionalParameters.МассивПуть[IndexOf]
		= AdditionalParameters.ПредопределенныеВеткиКонфигурации.DocumentJournal Then
		СтрокаДерева.ПредставлениеИмя = "Журналы документов";
		СтрокаДерева.ПредставлениеСиноним = "Журналы документов";
		СтрокаДерева.КлассОбъектовМетаданных = "DocumentJournal";
		СтрокаДерева.ФормироватьПредставлениеПодчиненныхСтрокИзСинонимаМетаданных = True;
		СтрокаДерева.Order = 33;
		СтрокаДерева.Picture = 4;

	ElsIf AdditionalParameters.МассивПуть[IndexOf]
		= AdditionalParameters.ПредопределенныеВеткиКонфигурации.Enum Then
		СтрокаДерева.ПредставлениеИмя = "Enums";
		СтрокаДерева.ПредставлениеСиноним = "Enums";
		СтрокаДерева.КлассОбъектовМетаданных = "Enum";
		СтрокаДерева.ФормироватьПредставлениеПодчиненныхСтрокИзСинонимаМетаданных = True;
		СтрокаДерева.Order = 34;
		//СтрокаДерева.Picture = 3;

	ElsIf AdditionalParameters.МассивПуть[IndexOf]
		= AdditionalParameters.ПредопределенныеВеткиКонфигурации.Report Then
		СтрокаДерева.ПредставлениеИмя = "Reports";
		СтрокаДерева.ПредставлениеСиноним = "Reports";
		СтрокаДерева.КлассОбъектовМетаданных = "Report";
		СтрокаДерева.ФормироватьПредставлениеПодчиненныхСтрокИзСинонимаМетаданных = True;
		СтрокаДерева.Order = 35;
		СтрокаДерева.Picture = 5;

	ElsIf AdditionalParameters.МассивПуть[IndexOf]
		= AdditionalParameters.ПредопределенныеВеткиКонфигурации.ExternalReport Then
		СтрокаДерева.ПредставлениеИмя = "ExternalReports";
		СтрокаДерева.ПредставлениеСиноним = "ExternalReports";
		СтрокаДерева.Order = 36;
		СтрокаДерева.Picture = 6;

	ElsIf AdditionalParameters.МассивПуть[IndexOf]
		= AdditionalParameters.ПредопределенныеВеткиКонфигурации.Processing Then
		СтрокаДерева.ПредставлениеИмя = "DataProcessors";
		СтрокаДерева.ПредставлениеСиноним = "DataProcessors";
		СтрокаДерева.КлассОбъектовМетаданных = "Processing";
		СтрокаДерева.ФормироватьПредставлениеПодчиненныхСтрокИзСинонимаМетаданных = True;
		СтрокаДерева.Order = 37;
		СтрокаДерева.Picture = 7;

	ElsIf AdditionalParameters.МассивПуть[IndexOf]
		= AdditionalParameters.ПредопределенныеВеткиКонфигурации.ExternalDataProcessor Then
		СтрокаДерева.ПредставлениеИмя = "ExternalDataProcessors";
		СтрокаДерева.ПредставлениеСиноним = "ExternalDataProcessors";
		СтрокаДерева.Order = 38;
		СтрокаДерева.Picture = 8;

	ElsIf AdditionalParameters.МассивПуть[IndexOf]
		= AdditionalParameters.ПредопределенныеВеткиКонфигурации.ChartOfCharacteristicTypes Then
		СтрокаДерева.ПредставлениеИмя = "Планы видов характеристик";
		СтрокаДерева.ПредставлениеСиноним = "Планы видов характеристик";
		СтрокаДерева.КлассОбъектовМетаданных = "ChartOfCharacteristicTypes";
		СтрокаДерева.ФормироватьПредставлениеПодчиненныхСтрокИзСинонимаМетаданных = True;
		СтрокаДерева.Order = 39;
		СтрокаДерева.Picture = 9;

	ElsIf AdditionalParameters.МассивПуть[IndexOf]
		= AdditionalParameters.ПредопределенныеВеткиКонфигурации.ChartOfAccounts Then
		СтрокаДерева.ПредставлениеИмя = "Планы счетов";
		СтрокаДерева.ПредставлениеСиноним = "Планы счетов";
		СтрокаДерева.КлассОбъектовМетаданных = "ChartOfAccounts";
		СтрокаДерева.ФормироватьПредставлениеПодчиненныхСтрокИзСинонимаМетаданных = True;
		СтрокаДерева.Order = 40;
		//СтрокаДерева.Picture = 6;

	ElsIf AdditionalParameters.МассивПуть[IndexOf]
		= AdditionalParameters.ПредопределенныеВеткиКонфигурации.ChartOfCalculationTypes Then
		СтрокаДерева.ПредставлениеИмя = "Планы видов расчета";
		СтрокаДерева.ПредставлениеСиноним = "Планы видов расчета";
		СтрокаДерева.КлассОбъектовМетаданных = "ChartOfCalculationTypes";
		СтрокаДерева.ФормироватьПредставлениеПодчиненныхСтрокИзСинонимаМетаданных = True;
		СтрокаДерева.Order = 41;
		//СтрокаДерева.Picture = 6;

	ElsIf AdditionalParameters.МассивПуть[IndexOf]
		= AdditionalParameters.ПредопределенныеВеткиКонфигурации.InformationRegister Then
		СтрокаДерева.ПредставлениеИмя = "Регистры сведений";
		СтрокаДерева.ПредставлениеСиноним = "Регистры сведений";
		СтрокаДерева.КлассОбъектовМетаданных = "InformationRegister";
		СтрокаДерева.ФормироватьПредставлениеПодчиненныхСтрокИзСинонимаМетаданных = True;
		СтрокаДерева.Order = 42;
		СтрокаДерева.Picture = 10;

	ElsIf AdditionalParameters.МассивПуть[IndexOf]
		= AdditionalParameters.ПредопределенныеВеткиКонфигурации.AccumulationRegister Then
		СтрокаДерева.ПредставлениеИмя = "Регистры накопления";
		СтрокаДерева.ПредставлениеСиноним = "Регистры накопления";
		СтрокаДерева.КлассОбъектовМетаданных = "AccumulationRegister";
		СтрокаДерева.ФормироватьПредставлениеПодчиненныхСтрокИзСинонимаМетаданных = True;
		СтрокаДерева.Order = 43;
		//СтрокаДерева.Picture = 6;

	ElsIf AdditionalParameters.МассивПуть[IndexOf]
		= AdditionalParameters.ПредопределенныеВеткиКонфигурации.AccountingRegister Then
		СтрокаДерева.ПредставлениеИмя = "Регистры бухгалтерии";
		СтрокаДерева.ПредставлениеСиноним = "Регистры бухгалтерии";
		СтрокаДерева.КлассОбъектовМетаданных = "AccountingRegister";
		СтрокаДерева.ФормироватьПредставлениеПодчиненныхСтрокИзСинонимаМетаданных = True;
		СтрокаДерева.Order = 44;
		//СтрокаДерева.Picture = 6;

	ElsIf AdditionalParameters.МассивПуть[IndexOf]
		= AdditionalParameters.ПредопределенныеВеткиКонфигурации.CalculationRegister Then
		СтрокаДерева.ПредставлениеИмя = "Регистры расчета";
		СтрокаДерева.ПредставлениеСиноним = "Регистры расчета";
		СтрокаДерева.КлассОбъектовМетаданных = "CalculationRegister";
		СтрокаДерева.ФормироватьПредставлениеПодчиненныхСтрокИзСинонимаМетаданных = True;
		СтрокаДерева.Order = 45;
		//СтрокаДерева.Picture = 6;

	ElsIf AdditionalParameters.МассивПуть[IndexOf]
		= AdditionalParameters.ПредопределенныеВеткиКонфигурации.BusinessProcess Then
		СтрокаДерева.ПредставлениеИмя = "Бизнес-процессы";
		СтрокаДерева.ПредставлениеСиноним = "Бизнес-процессы";
		СтрокаДерева.КлассОбъектовМетаданных = "BusinessProcess";
		СтрокаДерева.ФормироватьПредставлениеПодчиненныхСтрокИзСинонимаМетаданных = True;
		СтрокаДерева.Order = 46;
		//СтрокаДерева.Picture = 6;

	ElsIf AdditionalParameters.МассивПуть[IndexOf]
		= AdditionalParameters.ПредопределенныеВеткиКонфигурации.Task Then
		СтрокаДерева.ПредставлениеИмя = "Tasks";
		СтрокаДерева.ПредставлениеСиноним = "Tasks";
		СтрокаДерева.КлассОбъектовМетаданных = "Task";
		СтрокаДерева.ФормироватьПредставлениеПодчиненныхСтрокИзСинонимаМетаданных = True;
		СтрокаДерева.Order = 47;
		//СтрокаДерева.Picture = 6;

	ElsIf AdditionalParameters.МассивПуть[IndexOf]
		= AdditionalParameters.ПредопределенныеВеткиКонфигурации.ExternalDataSource Then
		СтрокаДерева.ПредставлениеИмя = "Внешние источники данных";
		СтрокаДерева.ПредставлениеСиноним = "Внешние источники данных";
		СтрокаДерева.КлассОбъектовМетаданных = "ExternalDataSource";
		СтрокаДерева.ФормироватьПредставлениеПодчиненныхСтрокИзСинонимаМетаданных = True;
		СтрокаДерева.Order = 48;
		//СтрокаДерева.Picture = 6;

	ElsIf AdditionalParameters.МассивПуть[IndexOf] = "Form" Then
		СтрокаДерева.ПредставлениеИмя = "Forms";
		СтрокаДерева.ПредставлениеСиноним = "Forms";
		СтрокаДерева.Picture = 1;

	Else
		СтрокаДерева.Picture = AdditionalParameters.НомерКартинки;

	EndIf;

	AdditionalParameters.НомерКартинки = СтрокаДерева.Picture;
	
	// FillType колонок дерева ПредставлениеСиноним, ОтсутствуетВКонфигурации
	If IndexOf > 0 And СтрокаДерева.Parent.ФормироватьПредставлениеПодчиненныхСтрокИзСинонимаМетаданных Then
		ОбъектМетаданных = Metadata.FindByFullName(СтрокаДерева.Parent.КлассОбъектовМетаданных + "."
			+ AdditionalParameters.МассивПуть[IndexOf]);
		If ОбъектМетаданных = Undefined Then
			СтрокаДерева.ОтсутствуетВКонфигурации = True;
			УстановитьОтсутствуетВКонфигурации(СтрокаДерева);
		Else
			СтрокаДерева.ПредставлениеСиноним = ОбъектМетаданных.Synonym;
		EndIf;
	EndIf;

EndFunction

&AtServer
Procedure УстановитьИдентификаторОтбора(СтрокаТаблицыНастроек, СтрокаДерева)

	СтрокаТаблицыНастроек["ИдентификаторОтбора" + СтрокаДерева.Level] = СтрокаДерева.ИдентификаторОтбора;

	СтрокаДерева.КоличествоНастроек = СтрокаДерева.КоличествоНастроек + 1;

	СтрокаРодитель = СтрокаДерева.Parent;
	If СтрокаРодитель.Parent <> Undefined Then
		// Рекурсия
		УстановитьИдентификаторОтбора(СтрокаТаблицыНастроек, СтрокаРодитель);
	EndIf;

EndProcedure

&AtServer
Procedure УстановитьОтсутствуетВКонфигурации(СтрокаДерева)

	СтрокаДерева.ОтсутствуетВКонфигурации = True;

	СтрокаРодитель = СтрокаДерева.Parent;
	If СтрокаРодитель.Parent <> Undefined Then
		// Рекурсия
		УстановитьОтсутствуетВКонфигурации(СтрокаРодитель);
	EndIf;

EndProcedure

&AtServer
Procedure УдалитьВыбранныеНастройкиНаСервере()
	ПараметрыОтбора = New Structure;
	ПараметрыОтбора.Insert("Check", True);
	НайденныеСтроки = ТаблицаНастроек.FindRows(ПараметрыОтбора);
	For Each String In НайденныеСтроки Do
		ХрНастроек = Eval(String.ИмяХранилищаНастроек);
		ХрНастроек.Delete(String.ObjectKey, String.SettingsKey, ВладелецНастроек);
	EndDo;

EndProcedure

&AtServer
Procedure СкопироватьВыбранныеНастройкиНаСервере()

	Filter = New Structure("Check", True);

	ВыбранныеПользователи = Users.FindRows(Filter);

	ВыбранныеНастроки = ТаблицаНастроек.FindRows(Filter);

	For Each СтрокаПользователь In ВыбранныеПользователи Do
		For Each СтрокаНастройка In ВыбранныеНастроки Do

			ХрНастроек = Eval(СтрокаНастройка.ИмяХранилищаНастроек);

			Filter = New Structure;
			Filter.Insert("ObjectKey", СтрокаНастройка.ObjectKey);
			Filter.Insert("SettingsKey", СтрокаНастройка.SettingsKey);
			Filter.Insert("User", СтрокаПользователь.Name);
			
			
			// Get настроки для копирования. Выборка ВыборкаНастроекИсточника должен содержать один элемент
			ВыборкаНастроекИсточника = ХрНастроек.StartChoosing(Filter);
			ВыборкаНастроекИсточника.Next();
			
			// Copy настройки новому пользователю
			ХрНастроек.Save(
				СтрокаНастройка.ObjectKey, СтрокаНастройка.SettingsKey, ВыборкаНастроекИсточника.Settings,
				СтрокаНастройка.Presentation, СтрокаПользователь.Name);

		EndDo;
	EndDo;

EndProcedure

&AtServer
Procedure ПросмотрНастроекНаСервере(ИмяХранилищаНастроек, ObjectKey, SettingsKey, UserName)

	Filter = New Structure;
	Filter.Insert("ObjectKey", ObjectKey);
	Filter.Insert("SettingsKey", SettingsKey);
	Filter.Insert("User", UserName);

	Выборка = Eval(ИмяХранилищаНастроек).StartChoosing(Filter);
	Выборка.Next();

	СодержимоеНастроек = Выборка.Settings;

EndProcedure

#EndRegion

/////////////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////////

#Region Прочее

#Region Управление_пометками

&AtClient
Procedure УстановитьПометкуПодчиненныхЭлементов(ЭлементДерева, Check)
	
	// Set пометку
	ЭлементДерева.Check = Check;

	ПараметрыОтбора = New Structure;
	ПараметрыОтбора.Insert("ИдентификаторОтбора" + ЭлементДерева.Level, ЭлементДерева.ИдентификаторОтбора);
	ПараметрыОтбора.Insert("Check", Not Check);
	НайденныеСтроки = ТаблицаНастроек.FindRows(ПараметрыОтбора);
	For Each String In НайденныеСтроки Do
		String.Check = (Check = 1);
	EndDo; 
	
	// Рекурсивная установка пометки у подчиненных строк дерева
	For Each ПодчиненныйЭлемент In ЭлементДерева.GetItems() Do
		УстановитьПометкуПодчиненныхЭлементов(ПодчиненныйЭлемент, Check);
	EndDo;

EndProcedure

&AtClient
Procedure УстановитьПометкуРодительскихЭлементов(ЭлементДерева, Check)
	
	// Set пометку
	ЭлементДерева.Check = Check;	
	
	// Рекурсивная установка пометки у родительских строк дерева
	ЭлементРодитель = ЭлементДерева.GetParent();
	If Not ЭлементРодитель = Undefined Then
		
		// Считаем количесвто помеченных элементов в подчиненном уровне
		КоличествоПомеченныхЭлеметов = 0;
		КоличествоСерыхЭлеметов = 0;
		ПодчиненныеЭлементыРодителя = ЭлементРодитель.GetItems();
		For Each ПодчиненныйЭлемент In ПодчиненныеЭлементыРодителя Do
			КоличествоПомеченныхЭлеметов = КоличествоПомеченныхЭлеметов + ?(ПодчиненныйЭлемент.Check = 1, 1, 0);
			КоличествоСерыхЭлеметов = КоличествоСерыхЭлеметов + ?(ПодчиненныйЭлемент.Check = 2, 1, 0);
		EndDo;
		
		// Устанавливаем пометки
		If КоличествоПомеченныхЭлеметов = 0 And КоличествоСерыхЭлеметов = 0 Then
			УстановитьПометкуРодительскихЭлементов(ЭлементРодитель, 0);
		ElsIf КоличествоПомеченныхЭлеметов = ПодчиненныеЭлементыРодителя.Count() Then
			УстановитьПометкуРодительскихЭлементов(ЭлементРодитель, 1);
		Else
			УстановитьПометкуРодительскихЭлементов(ЭлементРодитель, 2);
		EndIf;

	EndIf;

EndProcedure

&AtClient
Procedure УправлениеПометками(ЭлементДерева, ОтсекатьСеруюПометку = True)

	If ЭлементДерева = Undefined Then
		Return;
	EndIf;
	
	// отсечем серую пометку, считаем что сняли пометку
	If ОтсекатьСеруюПометку And ЭлементДерева.Check = 2 Then
		ЭлементДерева.Check = 0;
	EndIf;

	УстановитьПометкуПодчиненныхЭлементов(ЭлементДерева, ЭлементДерева.Check);
	УстановитьПометкуРодительскихЭлементов(ЭлементДерева, ЭлементДерева.Check);

EndProcedure

#EndRegion

#EndRegion