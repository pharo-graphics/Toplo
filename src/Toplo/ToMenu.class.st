Class {
	#name : #ToMenu,
	#superclass : #ToButtonMenuItem,
	#instVars : [
		'items'
	],
	#category : #'Toplo-Widget-Menu'
}

{ #category : #'item adding/removing' }
ToMenu >> addItem: aMenuItem [

	self items add: aMenuItem.
	self menuWindow addChild: aMenuItem.
	aMenuItem addedInMenu: self
]

{ #category : #window }
ToMenu >> close [

	self menuWindow close
]

{ #category : #'t - initialization dresser' }
ToMenu >> defaultDresser [

	^ ToMenuDresser new
]

{ #category : #initialization }
ToMenu >> initialize [ 

	super initialize.
	items := OrderedCollection new.
	menuWindow := ToMenuWindow new widget: self.
	self whenClickedDo: [ self popupOrClose ]
]

{ #category : #'item  accessing' }
ToMenu >> items [

	^ items
]

{ #category : #window }
ToMenu >> popup [

	self menuWindow popup
]

{ #category : #window }
ToMenu >> popupOrClose [

	self menuWindow isAttachedToSceneGraph
		ifTrue: [ self menuWindow close ]
		ifFalse: [ self menuWindow popup ]
]

{ #category : #'item adding/removing' }
ToMenu >> removeItem: aMenuItem [

	self items remove: aMenuItem.
	self menuWindow removeChild: aMenuItem.
	aMenuItem privateMenuWindow: nil.

]

{ #category : #initialization }
ToMenu >> rightIconImage [

	| ic |
	ic := super rightIconImage.
	ic background: Color red.
	ic constraintsDo: [ :c | 
			c linear vertical alignCenter.
			c linear horizontal alignCenter ].
	^ ic
"	^ ((ColorForm mappingWhiteToTransparentFrom: f) asFormOfDepth: 32) asElement"
]
