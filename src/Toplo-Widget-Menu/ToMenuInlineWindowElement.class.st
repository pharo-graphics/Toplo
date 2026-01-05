Class {
	#name : #ToMenuInlineWindowElement,
	#superclass : #ToCustomMenuItem,
	#traits : 'TToAnchoredWindowElement + TToMenuWindowModel',
	#classTraits : 'TToAnchoredWindowElement classTrait + TToMenuWindowModel classTrait',
	#category : #'Toplo-Widget-Menu-Window'
}

{ #category : #'t - menu window model' }
ToMenuInlineWindowElement >> closeWindow [

	self close
]

{ #category : #initialization }
ToMenuInlineWindowElement >> initialize [ 

	super initialize.
	self addEventHandler: ToMenuContainerEventHandler new
]

{ #category : #testing }
ToMenuInlineWindowElement >> isInline [ 

	^ true
]

{ #category : #testing }
ToMenuInlineWindowElement >> isScrollable: aBoolean [

	self itemList isScrollable: aBoolean
]

{ #category : #'t - menu window model' }
ToMenuInlineWindowElement >> isSubmenu [

	^ super isSubmenu
]

{ #category : #'t - menu window model' }
ToMenuInlineWindowElement >> isTopMenu [

	^ false
]

{ #category : #accessing }
ToMenuInlineWindowElement >> itemContainer [

	^ self element
]

{ #category : #accessing }
ToMenuInlineWindowElement >> itemList [

	^ self anchorElement itemList
]

{ #category : #accessing }
ToMenuInlineWindowElement >> items [

	^ self itemContainer ifNil: [ ^ #(  ) ] ifNotNil: [ :w | w items ]
]

{ #category : #'t - menu window model' }
ToMenuInlineWindowElement >> menuWindow [

	^ self 
]

{ #category : #skin }
ToMenuInlineWindowElement >> newRawSkin [ 

	^ ToMenuInlineWindowSkin new
]

{ #category : #'t - inline window element - accessing' }
ToMenuInlineWindowElement >> root [ 

	^ self
]

{ #category : #'api - displaying' }
ToMenuInlineWindowElement >> toThemeInstalled [

	| lt |
	self anchorElement ifNotNil: [ :e |
		lt := e lookupTheme.
		self localTheme = lt ifFalse: [ self localTheme: lt ] ].
	super toThemeInstalled
]
