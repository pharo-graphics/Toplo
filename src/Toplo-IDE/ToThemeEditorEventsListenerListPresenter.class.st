Class {
	#name : #ToThemeEditorEventsListenerListPresenter,
	#superclass : #SpPresenter,
	#traits : 'TToThemeEditorPresenterWithButtons',
	#classTraits : 'TToThemeEditorPresenterWithButtons classTrait',
	#instVars : [
		'eventListenersList'
	],
	#category : #'Toplo-IDE-theme-editor-presenter-eventListeners'
}

{ #category : #accessing }
ToThemeEditorEventsListenerListPresenter >> actionAddButton [

	self controller addEventListener.
]

{ #category : #accessing }
ToThemeEditorEventsListenerListPresenter >> actionRemoveButton [

	self controller removeEventListener:
		self eventListenersList selectedItem
]

{ #category : #accessing }
ToThemeEditorEventsListenerListPresenter >> addHelp [

	^ 'Add a new event listener.'
]

{ #category : #accessing }
ToThemeEditorEventsListenerListPresenter >> controllerClass [

	^ ToThemeEditorEventsListenerListController
]

{ #category : #layout }
ToThemeEditorEventsListenerListPresenter >> defaultLayout [

	^ SpBoxLayout newVertical
		  spacing: 4;
		  add: self eventListenersList expand: true;
		  add: self buttonsLayout expand: false;
		  yourself
]

{ #category : #initialization }
ToThemeEditorEventsListenerListPresenter >> eventListenerMenu [

	^ SpMenuPresenter new
		  addItem: [ :item |
			  item
				  icon: (self iconNamed: #smallInspectIt);
				  name: 'Inspect';
				  action: [ self eventListenersList selectedItem inspect ];
				  yourself ];
		  yourself
]

{ #category : #accessing }
ToThemeEditorEventsListenerListPresenter >> eventListenersList [

	^ eventListenersList
]

{ #category : #initialization }
ToThemeEditorEventsListenerListPresenter >> initializePresenters [

	eventListenersList := SpTablePresenter new
		                      whenSelectedItemChangedDo: [ :anEventListener |
			                      self selectedEventListenerChanged:
					                      anEventListener ];
		                      contextMenu: self eventListenerMenu;
		                      yourself.
	eventListenersList addColumn:
		((SpStringTableColumn title: 'Event' evaluated: [ :eventListner |
			  (eventListner eventClass printString allButFirst: 2) allButLast:
				  9 ]) width: 70).
	eventListenersList addColumn:
		((SpStringTableColumn title: 'Type' evaluated: [ :eventListner |
			  eventListner isAction
				  ifTrue: [ 'Action' ]
				  ifFalse: [ 'Property' ] ]) width: 70).
	eventListenersList addColumn:
		(SpStringTableColumn title: 'Property' evaluated: [ :eventListner |
			 eventListner isAction
				 ifTrue: [ '' ]
				 ifFalse: [ eventListner property name ] ])
]

{ #category : #accessing }
ToThemeEditorEventsListenerListPresenter >> removeHelp [

	^ 'Remove the selected event listener.'
]

{ #category : #initialization }
ToThemeEditorEventsListenerListPresenter >> selectedEventListenerChanged: anEventListener [

	self controller selectedEventListenerChanged: anEventListener
]

{ #category : #initialization }
ToThemeEditorEventsListenerListPresenter >> updatePresenter [

	self eventListenersList items: self controller allEventListeners.
	self updatePresenterOnlyButtons
]
