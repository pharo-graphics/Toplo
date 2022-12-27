Class {
	#name : #ToMenuBar,
	#superclass : #ToElement,
	#traits : 'TToWidget + TToOrientable',
	#classTraits : 'TToWidget classTrait + TToOrientable classTrait',
	#instVars : [
		'menus'
	],
	#category : #'Toplo-Widget-MenuBar'
}

{ #category : #initialize }
ToMenuBar >> adaptToOrientation [

	self isHorizontal
		ifTrue: [ 
			self hMatchParent.
			self vFitContent ]
		ifFalse: [ 
			self vMatchParent.
			self hFitContent ]
]

{ #category : #adding }
ToMenuBar >> addFiller [

	| filler |
	self addChild: (filler := ToMenuBarFiller new).
	filler addedInMenuBar: self
]

{ #category : #adding }
ToMenuBar >> addMenu: aMenu [

	self menus add: aMenu.
	aMenu constraintsDo: [ :c | c linear vertical alignCenter ].
	aMenu constraintsDo: [ :c | c linear horizontal alignCenter ].
	self addChild: aMenu.
	aMenu addedInMenuBar: self
]

{ #category : #adding }
ToMenuBar >> addSeparator [

	| sep |
	self addChild: (sep := ToMenuBarSeparator new).
	sep addedInMenuBar: self
]

{ #category : #'t - initialization dresser' }
ToMenuBar >> defaultDresser [ 

	^ ToMenuBarDresser new
]

{ #category : #initialize }
ToMenuBar >> initialize [

	super initialize.
	self layout: BlLinearLayout new.
	self beHorizontal.
	
	menus := OrderedCollection new.
	
	self initializeDresser.
	self whenOrientationChangedDo: [ self adaptToOrientation ]
]

{ #category : #accessing }
ToMenuBar >> menus [

	^ menus
]

{ #category : #adding }
ToMenuBar >> removeMenu: aMenu [

	self menus remove: aMenu.
	self removeChild: aMenu.
	aMenu removedFromMenuBar: self
]
