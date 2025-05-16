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
	r := self rootMenuItemContainer ifNil: [ ^ self ].
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
	r := self rootMenuItemContainer ifNil: [ ^ self ].
	r allChildrenDepthFirstDo: [ :child |
		(child ~= self and: [
			 (child isKindOf: ToMenu) ]) ifTrue: [
			child menuWindowDo: aValuable ] ]
]

{ #category : #'t - menu item' }
TToMenuItem >> barOwnerDo: aValuable [

	self menuBarOwner ifNotNil: [ :bo | aValuable value: bo ]
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
TToMenuItem >> isSubmenu [ 

	^ false
]

{ #category : #'t - menu item' }
TToMenuItem >> menuBarOwner [

	^ self listElement ifNotNil: [ :be | be menuBarOwner ]
]

{ #category : #'t - menu item' }
TToMenuItem >> menuPane [

	self parentChainReverseDo: [ :e |
		(e isKindOf: ToMenuPane) ifTrue: [ ^ e ] ].
	^ nil
]

{ #category : #'t - menu item' }
TToMenuItem >> parentMenu [

	self flag: #ToBeChecked.
	^ self menuBarOwner 
	ifNotNil: [ :bo |
		  bo isMenuPane
			  ifTrue: [  ]
			  ifFalse: [ bo ] ]
]

{ #category : #'t - menu item' }
TToMenuItem >> parentMenuDo: aBlock [

	self parentMenu ifNotNil: [ :p | aBlock value: p ]
]

{ #category : #'t - menu item' }
TToMenuItem >> rootMenuItemContainer [

	self parentChainReverseDo: [ :e |
		((e isKindOf: ToMenuWindow) or: [ e isKindOf: ToMenuPane ]) ifTrue: [
			^ e ] ].
	^ nil
]

{ #category : #'t - menu item' }
TToMenuItem >> showExpandIcon [

	^ false
]
