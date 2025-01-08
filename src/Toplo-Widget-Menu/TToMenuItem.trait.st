Trait {
	#name : #TToMenuItem,
	#category : #'Toplo-Widget-Menu-Items'
}

{ #category : #'t - menu item' }
TToMenuItem >> allMenuWindows [

	^ Array streamContents: [ :stream |
		  self allMenuWindowsDo: [ :mw | stream nextPut: mw ] ]
]

{ #category : #'t - menu item' }
TToMenuItem >> allMenuWindowsDo: aValuable [

	| r |
	r := self rootMenuWindowOrMenuBar ifNil: [ ^ self ].
	r allChildrenDepthFirstDo: [ :child |
		(child isKindOf: ToMenu) ifTrue: [ child menuWindowDo: aValuable ] ]
]

{ #category : #'t - menu item' }
TToMenuItem >> allOtherMenuWindows [

	^ Array streamContents: [ :stream |
		  self allOtherMenuWindowsDo: [ :mw | stream nextPut: mw ] ]
]

{ #category : #'t - menu item' }
TToMenuItem >> allOtherMenuWindowsDo: aValuable [

	| r |
	r := self rootMenuWindowOrMenuBar ifNil: [ ^ self ].
	r allChildrenDepthFirstDo: [ :child |
		(child ~= self and: [
			 (child isKindOf: ToMenu) ]) ifTrue: [
			child menuWindowDo: aValuable ] ]
]

{ #category : #'t - menu item' }
TToMenuItem >> closeAllOtherPopupMenuWindows [

	self allOtherMenuWindowsDo: [ :mw |
		mw isInline ifFalse: [ mw close ] ]
]

{ #category : #'t - menu item' }
TToMenuItem >> closeAllPopupMenuWindows [

	self allMenuWindowsDo: [ :mw |
		mw isInline ifFalse: [ mw close ] ]
]

{ #category : #'t - menu item' }
TToMenuItem >> closeOnPicking [ 

	^ true
]

{ #category : #'t - menu item' }
TToMenuItem >> isInInlineWindow [

	self parentMenuDo: [ :m | ^ m isInline ].
	^ false
]

{ #category : #'t - menu item' }
TToMenuItem >> isMenuItem [ 

	^ true
]

{ #category : #'t - menu item' }
TToMenuItem >> isRootMenuItem [ 

	^ self parentItemListHolder isNil  or: [ self parentItemListHolder isMenuBar ]
]

{ #category : #'t - menu item' }
TToMenuItem >> isSubmenu [ 

	^ false
]

{ #category : #'t - menu item' }
TToMenuItem >> menuBar [

	self parentChainReverseDo: [ :e |
		(e isKindOf: ToMenuBar) ifTrue: [ ^ e ] ].
	^ nil
]

{ #category : #'t - menu item' }
TToMenuItem >> parentMenu [

	self parentItemListHolder ifNil: [ ^ nil ].
	self parentItemListHolder isMenuBar ifTrue: [ ^ nil ].
	^ self parentItemListHolder
]

{ #category : #'t - menu item' }
TToMenuItem >> parentMenuDo: aBlock [

	self parentMenu ifNotNil: [ :p | aBlock value: p ]
]

{ #category : #'t - menu item' }
TToMenuItem >> popupWindowParentMenu [

	| win |
	win := self firstInParentChainSatisfying: [ :p |
		       p isKindOf: ToMenuWindow ].
	win ifNotNil: [ ^ win itemContainer ].
	^ nil
]

{ #category : #'t - menu item' }
TToMenuItem >> popupWindowParentMenuDo: aBlock [

	self popupWindowParentMenu ifNotNil: [ :p | aBlock value: p ]
]

{ #category : #'t - menu item' }
TToMenuItem >> rootMenuWindowOrMenuBar [

	self parentChainReverseDo: [ :e |
		((e isKindOf: ToMenuWindow) or: [ e isKindOf: ToMenuBar ]) ifTrue: [
			^ e ] ].
	^ nil
]
