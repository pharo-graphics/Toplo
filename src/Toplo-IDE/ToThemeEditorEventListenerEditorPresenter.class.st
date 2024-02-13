Class {
	#name : #ToThemeEditorEventListenerEditorPresenter,
	#superclass : #SpPresenter,
	#traits : 'TToThemeEditorPresenterWithController + TToThemeEditorPresenterWithApplyButton',
	#classTraits : 'TToThemeEditorPresenterWithController classTrait + TToThemeEditorPresenterWithApplyButton classTrait',
	#instVars : [
		'propertyRadio',
		'actionRadio',
		'eventClassDropList',
		'currentSpecializationPanel'
	],
	#category : #'Toplo-IDE-theme-editor-presenter-eventListenerEditor'
}

{ #category : #accessing }
ToThemeEditorEventListenerEditorPresenter >> actionApplyButton [

	^ self controller replaceEventListener
]

{ #category : #accessing }
ToThemeEditorEventListenerEditorPresenter >> actionRadio [

	^ actionRadio
]

{ #category : #accessing }
ToThemeEditorEventListenerEditorPresenter >> controllerClass [

	^ ToThemeEditorEventListenerEditorController
]

{ #category : #initialization }
ToThemeEditorEventListenerEditorPresenter >> currentSpecializationPanel [

	^ currentSpecializationPanel ifNil: [
		currentSpecializationPanel := self controller
			                              currentSpecializeController ]
]

{ #category : #initialization }
ToThemeEditorEventListenerEditorPresenter >> currentSpecializationPanel: aSpPanel [
	self layout replace: currentSpecializationPanel with: aSpPanel.
	currentSpecializationPanel := aSpPanel

	
]

{ #category : #layout }
ToThemeEditorEventListenerEditorPresenter >> defaultLayout [

	^ SpBoxLayout newVertical
		  spacing: 4;
		  add: self topLayout expand: false;
		  add: self eventClassDropList expand: false;
		  add: (SpBoxLayout newHorizontal
				   spacing: 4;
				   add: self propertyRadio;
				   add: self actionRadio;
				   yourself)
		  expand: false;
		  add: self currentSpecializationPanel expand: true;
		  yourself
]

{ #category : #accessing }
ToThemeEditorEventListenerEditorPresenter >> eventClassDropList [

	^ eventClassDropList
]

{ #category : #initialization }
ToThemeEditorEventListenerEditorPresenter >> initializePresenters [

	propertyRadio := SpRadioButtonPresenter new
		                 label: 'Property mode';
		                 yourself.
	actionRadio := SpRadioButtonPresenter new
		               label: 'Action mode';
		               yourself.
	actionRadio associatedRadioButtons: { propertyRadio }.
	actionRadio state: true.
	actionRadio whenChangedDo: [ :s | self updatePresenter ].
	eventClassDropList := SpDropListPresenter new display: [:eventClass | eventClass eventName]; yourself.
	self controller populateEventClassDropList: eventClassDropList
]

{ #category : #specs }
ToThemeEditorEventListenerEditorPresenter >> panelName [

	^ 'Event Listener Editor'
]

{ #category : #accessing }
ToThemeEditorEventListenerEditorPresenter >> propertyRadio [

	^ propertyRadio
]

{ #category : #initialization }
ToThemeEditorEventListenerEditorPresenter >> updatePresenter [

	self enabled: self controller isPresenterEnabled.
	self currentSpecializationPanel:
		self controller currentSpecializeController.
]
