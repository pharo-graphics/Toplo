Class {
	#name : #ToMenuInlineWindowElement,
	#superclass : #ToCustomMenuItem,
	#traits : 'TToAnchoredWindowElement + TToMenuWindowModel',
	#classTraits : 'TToAnchoredWindowElement classTrait + TToMenuWindowModel classTrait',
	#category : #'Toplo-Widget-Menu-Window'
}

{ #category : #layout }
ToMenuInlineWindowElement >> bottomUpUdateWidthWith: aWidth [
	" update all my item list node width according to the most width node.
	This is gone by computing a value for the configuration exactNodeWidth "

	| mx |
	" first don't do anything from here if the passed width is less or equals than my actual exactNodeWidth "
	self itemList toConfiguration exactNodeWidth ifNotNil: [ :actualWidth |
		actualWidth >= aWidth ifTrue: [ ^ self ] ].
	mx := aWidth.
	" compute the max "
	self itemList nodes do: [ :node | mx := mx max: node measuredWidth ].
	" set my exactNodeWidth with the max. this will update all the nodes "
	self itemList toConfiguration exactNodeWidth: mx.
	" do the same for my parent menu window if it is inline "
	self parentMenuDo: [ :pm |
			pm isInline ifFalse: [ ^ self ].
			pm menuWindowDo: [ :mw | mw bottomUpUdateWidthWith: mx ] ]
]

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
