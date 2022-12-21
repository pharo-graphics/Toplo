Class {
	#name : #ToMenuBar,
	#superclass : #ToElement,
	#traits : 'TToOrientableWidget',
	#classTraits : 'TToOrientableWidget classTrait',
	#instVars : [
		'menus'
	],
	#category : #'Toplo-Widget-MenuBar'
}

{ #category : #adding }
ToMenuBar >> addFiller [

	self addChild: (ToElement new
			 id: #'match-parent-fill';
			 matchParent)
]

{ #category : #adding }
ToMenuBar >> addMenu: aMenu [

	self menus add: aMenu.
	aMenu constraintsDo: [ :c | c linear vertical alignCenter ].
	aMenu constraintsDo: [ :c | c linear horizontal alignCenter ].
	self addChild: aMenu
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
	
	self initializeDresser 
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
