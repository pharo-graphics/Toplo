Class {
	#name : #MyCircularMenu,
	#superclass : #ToPane,
	#instVars : [
		'menuItems'
	],
	#category : #'Toplo-Widget-Menu-Circular'
}

{ #category : #example }
MyCircularMenu class >> exampleCircularMenu [

	| circularMenu icon circularItem |
	circularMenu := MyCircularMenu new.
	{ 2. 4 } do: [ :i |
			icon := ToMaterialDesignIconProvider iconNamed: 'outlined_info'.
			icon extent: 5 asPoint.
			circularItem := MyCircularMenuItem new.
			circularItem clickAction: [ self inform: i asString ].
			circularItem icon: icon.
			circularMenu addMenuItem: circularItem at: i ].
	circularMenu openInSpace 
	
]

{ #category : #api }
MyCircularMenu >> addMenuItem: aCircularMenuItem at: anIndex [

	aCircularMenuItem ifNil: [ ^ self ].
	self menuItems at: anIndex put: aCircularMenuItem.
	self rebuildMenuItems
]

{ #category : #private }
MyCircularMenu >> buildEmptyMenuItem [

	| empty |
	empty := (ToImage inner: MyCircularMenuItem menuItemSvg).
	empty innerImageColor: ((Color black) alpha: 0.5).
	empty extent: self emptyItemExtent.
	^ empty
]

{ #category : #accessing }
MyCircularMenu >> centerCircleExtent [

	^ 60 asPoint
]

{ #category : #accessing }
MyCircularMenu >> centerElement [

	^ self childWithId: self centerElementId ifNone: [ nil ]
]

{ #category : #accessing }
MyCircularMenu >> centerElementId [

	^ #centerElementId
]

{ #category : #accessing }
MyCircularMenu >> emptyItemExtent [

	^ 75 asPoint
]

{ #category : #private }
MyCircularMenu >> getChildContentTransformationAt: anIndex [

	| rotationDegree positionX positiony |
	rotationDegree := ((anIndex - 1) * 45) negated.

	positionX := self emptyItemExtent x / 2.
	positiony := self emptyItemExtent y + (self centerCircleExtent x / 2).

	^ [ :t | t rotateBy: rotationDegree ]
]

{ #category : #private }
MyCircularMenu >> getChildTransformationAt: anIndex [

	| rotationDegree positionX positiony |
	rotationDegree := (anIndex - 1) * 45.

	positionX := self emptyItemExtent x / 2.
	positiony := self emptyItemExtent y + (self centerCircleExtent x / 2).

	^ [ :t |
		  t origin: (BlAffineTransformationPositionOrigin new
				   position: positionX @ positiony;
				   yourself).
		  t rotateBy: rotationDegree ]
]

{ #category : #initialization }
MyCircularMenu >> initialize [

	super initialize.
	self layout: BlAnchorLayout new.
	self initializeCenterElement.
	self extent: self centerCircleExtent + (self emptyItemExtent * 2).

	menuItems := OrderedCollection new.
	1 to: self menuItemsMaxSize do: [ :i |
		menuItems add: self buildEmptyMenuItem ].

	self rebuildMenuItems
]

{ #category : #private }
MyCircularMenu >> initializeCenterElement [

	| element |
	element := ToElement new id: self centerElementId.
	element extent: self centerCircleExtent.
	element geometry: BlCircleGeometry new.
	element constraintsDo: [ :c |
			c anchors add: (element verticalCenterAnchor on: self verticalCenterAnchor).
			c anchors add: (element horizontalCenterAnchor on: self horizontalCenterAnchor) ].
	self addChild: element
]

{ #category : #accessing }
MyCircularMenu >> menuItems [

	^ menuItems
]

{ #category : #accessing }
MyCircularMenu >> menuItemsMaxSize [

	^ 12
]

{ #category : #private }
MyCircularMenu >> rebuildMenuItems [

	| childTransformation childContentTransformation |
	self centerElement ifNil: [ ^ self ].
	self menuItems do: [ :item | item removeFromParent ]. 

	self menuItems doWithIndex: [ :item :index |
			childTransformation := self getChildTransformationAt: index.
			childContentTransformation := self getChildContentTransformationAt: index.
			item transformDo: childTransformation.
			item class name = MyCircularMenuItem name ifTrue: [
				item hasIcon ifTrue: [ item icon transformDo: childContentTransformation] ].
			item constraintsDo: [ :c |
					c anchors add: (item horizontalCenterAnchor on: self centerElement horizontalCenterAnchor).
					c anchors add: (item bottomAnchor on: self centerElement topAnchor) ].

			self addChild: item ]
]
