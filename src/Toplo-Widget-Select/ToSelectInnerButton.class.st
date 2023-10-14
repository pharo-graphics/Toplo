Class {
	#name : 'ToSelectInnerButton',
	#superclass : 'ToMenuItem',
	#traits : 'TToMenuItemHolder + TToMenuWindowModel',
	#classTraits : 'TToMenuItemHolder classTrait + TToMenuWindowModel classTrait',
	#instVars : [
		'items',
		'menuWindow'
	],
	#category : 'Toplo-Widget-Select',
	#package : 'Toplo-Widget-Select'
}

{ #category : 'as yet unclassified' }
ToSelectInnerButton >> close [

	^ self window close
]

{ #category : 'initialization' }
ToSelectInnerButton >> initialize [

	super initialize.
	self beLabelFirst.
	self justified: true.
	self icon: (ToImage inner: (Smalltalk ui icons iconNamed: #bottom))	
]

{ #category : 't - menu item holder - accessing' }
ToSelectInnerButton >> items [

	^ items ifNil: [ items := OrderedCollection new ]
]

{ #category : 't - menu window model' }
ToSelectInnerButton >> popupEvent: anEvent [

	^ self window popupEvent: anEvent
]

{ #category : 'theme event handling' }
ToSelectInnerButton >> toThemeChanged [ 

	super toThemeChanged.
	self window ifNotNil: [ :mw | mw toThemeChanged ]
]

{ #category : 'as yet unclassified' }
ToSelectInnerButton >> window [

	^ menuWindow ifNil: [
		  menuWindow := ToMenuWindow new
			                widget: self;
			                yourself ]
]
