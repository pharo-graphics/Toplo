Class {
	#name : #ToSelectInnerButton,
	#superclass : #ToMenuItem,
	#traits : 'TToMenuItemHolder + TToMenuWindowModel',
	#classTraits : 'TToMenuItemHolder classTrait + TToMenuWindowModel classTrait',
	#instVars : [
		'menuWindow'
	],
	#category : #'Toplo-Widget-Select'
}

{ #category : #'t - menu window model - window opening/closing' }
ToSelectInnerButton >> close [

	^ self window close
]

{ #category : #initialization }
ToSelectInnerButton >> defaultEventHandler [ 

	ToMenuWindowModelEventHandlerDep.
	^ super defaultEventHandler
]

{ #category : #initialization }
ToSelectInnerButton >> initialize [

	super initialize.
	self beLabelFirst.
	self justified: true.
	self icon: (ToImage inner: (Smalltalk ui icons iconNamed: #bottom)).
	self initializeMenuItemHolder.
	
]

{ #category : #'t - menu window model - window opening/closing' }
ToSelectInnerButton >> popupEvent: anEvent [

	^ self window popupEvent: anEvent
]

{ #category : #'theme event handling' }
ToSelectInnerButton >> toThemeChanged [ 

	super toThemeChanged.
	self window ifNotNil: [ :mw | mw toThemeChanged ]
]

{ #category : #'t - menu window model - accessing' }
ToSelectInnerButton >> window [

	^ menuWindow ifNil: [
		  menuWindow := ToMenuWindow new
			                widget: self;
			                yourself ]
]
