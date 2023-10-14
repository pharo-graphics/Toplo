Class {
	#name : 'ToMenuBar',
	#superclass : 'ToElement',
	#traits : 'TToOrientable',
	#classTraits : 'TToOrientable classTrait',
	#instVars : [
		'menus'
	],
	#category : 'Toplo-Widget-Menu-Bar',
	#package : 'Toplo-Widget-Menu',
	#tag : 'Bar'
}

{ #category : 'initialize' }
ToMenuBar >> adaptToOrientation [

	self isHorizontal
		ifTrue: [ 
			self hMatchParent.
			self vFitContent ]
		ifFalse: [ 
			self vMatchParent.
			self hFitContent ]
]

{ #category : 'adding' }
ToMenuBar >> addFiller [

	| filler |
	self addChild: (filler := ToMenuBarFiller new)
]

{ #category : 'adding' }
ToMenuBar >> addMenu: aMenu [

	self menus add: aMenu.
	aMenu constraintsDo: [ :c | c linear vertical alignCenter ].
	aMenu constraintsDo: [ :c | c linear horizontal alignCenter ].
	self addChild: aMenu.
	self when: ToLayoutOrientationChangedEvent do: [ 
		self isHorizontal
			ifTrue: [ aMenu hFitContent ]
			ifFalse: [ aMenu hMatchParent ] ].
	self dispatchEvent: (ToMenuBarMenuAddedEvent new menu: aMenu)
]

{ #category : 'adding' }
ToMenuBar >> addSeparator [

	| sep |
	self addChild: (sep := ToMenuBarSeparator new).
	self when: ToLayoutOrientationChangedEvent do: [ sep horizontal: self isHorizontal not ].
	sep horizontal: self isHorizontal not
]

{ #category : 'initialize' }
ToMenuBar >> initialize [ 

	super initialize.

	self layout: BlLinearLayout new.
	self layout cellSpacing: 5.
	self background: Color transparent.
	self border: BlBorder empty.
	self padding: (BlInsets all: 4).
	self beHorizontal.	
	self when: ToLayoutOrientationChangedEvent do: [ self adaptToOrientation ].
	menus := OrderedCollection new.
	self addEventFilter: ToMenuBarEventHandler new
]

{ #category : 't - orientable - accessing' }
ToMenuBar >> layoutStrategy [

	^ self layout


]

{ #category : 'accessing' }
ToMenuBar >> menus [

	^ menus
]

{ #category : 'adding' }
ToMenuBar >> removeMenu: aMenu [

	self menus remove: aMenu.
	self removeChild: aMenu.
	self dispatchEvent: (ToMenuBarMenuRemovedEvent new menu: aMenu)
]
