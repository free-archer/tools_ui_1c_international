&Вместо("ПодключитьВнешнююОбработку")
Функция УИ_ПодключитьВнешнююОбработку(Ссылка) Экспорт
	НастройкаОтладки=UT_Common.НастройкиОтладкиДополнительнойОбработки(Ссылка);

	ЕстьОтладка=Ложь;
	Если НастройкаОтладки.ОтладкаВключена И ЗначениеЗаполнено(НастройкаОтладки.ИмяФайлаНаСервере) Тогда
		Если НастройкаОтладки.Пользователь=Неопределено 
			Или Не ЗначениеЗаполнено(НастройкаОтладки.Пользователь) Тогда
				
			ЕстьОтладка=Истина;
		ИначеЕсли НастройкаОтладки.Пользователь=Users.CurrentUser() Тогда
			ЕстьОтладка=Истина;
			
		КонецЕсли;
	КонецЕсли;

	Если Не ЕстьОтладка Тогда
		Возврат ПродолжитьВызов(Ссылка);
	Иначе
		
		ФайлОбработки = Новый Файл(НастройкаОтладки.ИмяФайлаНаСервере);
		Если НЕ ФайлОбработки.Существует() Тогда
		
			ХранилищеОбработки = Common.ЗначениеРеквизитаОбъекта(Ссылка, "ХранилищеОбработки");
			ДвоичныеДанные = ХранилищеОбработки.Получить();
			ДвоичныеДанные.Записать(НастройкаОтладки.ИмяФайлаНаСервере);
		
		КонецЕсли; 
		
		Вид = Common.ObjectAttributeValue(Ссылка, "Вид");
		Если Вид = Перечисления.ВидыДополнительныхОтчетовИОбработок.Отчет
			Или Вид = Перечисления.ВидыДополнительныхОтчетовИОбработок.ДополнительныйОтчет Тогда
			Менеджер = ВнешниеОтчеты;
		Иначе
			Менеджер = ВнешниеОбработки;
		КонецЕсли;

		ОбработкаОбъект = Менеджер.Создать(НастройкаОтладки.ИмяФайлаНаСервере, Ложь);
		
		Возврат СокрЛП(ОбработкаОбъект.Метаданные().Имя);

		
		Возврат НастройкаОтладки.ИмяФайлаНаСервере;
	КонецЕсли;
	
КонецФункции
