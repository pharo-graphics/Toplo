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
	self addChild: (filler := ToMenuBarFiller new)
]

{ #category : #adding }
ToMenuBar >> addMenu: aMenu [

	self menus add: aMenu.
	aMenu constraintsDo: [ :c | c linear vertical alignCenter ].
	aMenu constraintsDo: [ :c | c linear horizontal alignCenter ].
	self addChild: aMenu.
	self whenOrientationChangedDo: [ 
		self isHorizontal
			ifTrue: [ aMenu hFitContent ]
			ifFalse: [ aMenu hMatchParent ] ]
]

{ #category : #adding }
ToMenuBar >> addSeparator [

	| sep |
	self addChild: (sep := ToMenuBarSeparator new).
	self whenOrientationChangedDo: [ sep horizontal: self isHorizontal not ].
	sep horizontal: self isHorizontal not
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
	self whenOrientationChangedDo: [ self adaptToOrientation ].
	menus := OrderedCollection new.
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
