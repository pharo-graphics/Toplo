Class {
	#name : #ToploPanelEventListenerEditor,
	#superclass : #SpPresenter,
	#instVars : [
		'eventListener',
		'eventSelector',
		'actionRadio',
		'actionPresenter',
		'propertyRadio',
		'propertyPresenter',
		'buttonApply',
		'whenListenerChangedDo'
	],
	#category : #'Toplo-IDE-theme-editor-deprecated'
}

{ #category : #initialization }
ToploPanelEventListenerEditor >> actionPresenter [

	^ actionPresenter
]

{ #category : #initialization }
ToploPanelEventListenerEditor >> actionRadio [

	^ actionRadio
]

{ #category : #'as yet unclassified' }
ToploPanelEventListenerEditor >> applyToSelectedListener [

	self whenListenerChangedDo value: self makeNewListener value: self eventListener
]

{ #category : #initialization }
ToploPanelEventListenerEditor >> buttonApply [
	^ buttonApply
]

{ #category : #'as yet unclassified' }
ToploPanelEventListenerEditor >> currentEditorPresenter [

	self propertyRadio state ifTrue: [ ^ self propertyPresenter ].
	^ self actionPresenter
]

{ #category : #initialization }
ToploPanelEventListenerEditor >> defaultLayout [

	^ SpBoxLayout newVertical
		  spacing: 4;
		add: self buttonApply expand: false;
		  add: (SpBoxLayout newHorizontal
				   spacing: 4;
				   add: 'Type:' expand: false;
				   add: self actionRadio expand: false;
				   add: self propertyRadio expand: false;
				   yourself)
		  expand: false;
		  add: (SpBoxLayout newHorizontal
				   spacing: 4;
				   add: 'Event:' expand: false;
				   add: self eventSelector expand: true;
				   yourself)
		  expand: false;
		  add: self currentEditorPresenter expand: true;
		  yourself
]

{ #category : #accessing }
ToploPanelEventListenerEditor >> eventListener [

	^ eventListener
]

{ #category : #accessing }
ToploPanelEventListenerEditor >> eventListener: anEventListener [

	eventListener := anEventListener.
	self updatePresenter
]

{ #category : #initialization }
ToploPanelEventListenerEditor >> eventSelector [

	^ eventSelector
]

{ #category : #initialization }
ToploPanelEventListenerEditor >> initializePresenters [

	whenListenerChangedDo := [ :new :old |  ].
	eventSelector := SpDropListPresenter new
		                 items:
			                 (ToElementLookEvent allSubclasses reject: [ :each |
					                  each isAbstract ]);
		                 yourself.

	actionRadio := SpRadioButtonPresenter new
		               label: 'action';
		               yourself.
	propertyRadio := SpRadioButtonPresenter new
		                 label: 'property writer';
		                 yourself.
	actionRadio associatedRadioButtons: { propertyRadio }.
	buttonApply := SpButtonPresenter new
		               label: 'Apply to selected listener.';
		               action: [ self applyToSelectedListener ];
		               yourself.

	actionPresenter := ToploPanelInsideEventEditorForAction new.
	propertyPresenter := ToploPanelInsideEventEditorForPropertyWriter new.
	propertyRadio whenChangedDo: [ self layout: self defaultLayout ]
]

{ #category : #'as yet unclassified' }
ToploPanelEventListenerEditor >> makeNewListener [

	| listener |
	listener := self propertyRadio state
		            ifTrue: [ self propertyPresenter makeNewListener ]
		            ifFalse: [ self actionPresenter makeNewListener ].
	listener eventClass: self eventSelector selectedItem.
	^ listener
]

{ #category : #'as yet unclassified' }
ToploPanelEventListenerEditor >> propertyPresenter [

	^ propertyPresenter
]

{ #category : #initialization }
ToploPanelEventListenerEditor >> propertyRadio [

	^ propertyRadio
]

{ #category : #accessing }
ToploPanelEventListenerEditor >> theme: aToTheme [

	self propertyPresenter theme: aToTheme
]

{ #category : #initialization }
ToploPanelEventListenerEditor >> updatePresenter [

	self eventListener ifNil: [ ^ self ].
	self eventSelector selectItem: self eventListener eventClass.
	self propertyPresenter eventListener: self eventListener.
	self actionPresenter eventListener: self eventListener.
	self eventListener isAction
		ifTrue: [ self actionRadio click ]
		ifFalse: [ self propertyRadio click ]
]

{ #category : #'as yet unclassified' }
ToploPanelEventListenerEditor >> whenListenerChangedDo [

	^ whenListenerChangedDo
]

{ #category : #'as yet unclassified' }
ToploPanelEventListenerEditor >> whenListenerChangedDo: aBlockClosure [

	whenListenerChangedDo := aBlockClosure
]
