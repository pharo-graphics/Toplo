Trait {
	#name : #TToMenuItem,
	#category : #'Toplo-Widget-Menu-Items'
}

{ #category : #'t - menu item' }
TToMenuItem >> allOtherMenuWindowsDo: aValuable [

	self rootMenuWindowOrMenuPaneDo: [ :rmc |
			rmc allChildrenDepthFirstDo: [ :child |
					(child ~= self and: [ child isKindOf: ToMenu ]) ifTrue: [
						child menuWindowDo: aValuable ] ] ]
]

{ #category : #'t - menu item' }
TToMenuItem >> barOwnerDo: aValuable [

	self menuBarOwner ifNotNil: [ :bo | aValuable value: bo ]
]

{ #category : #'t - menu item' }
TToMenuItem >> closeAllSiblingMenuWindows [

	self allOtherMenuWindowsDo: [ :mw |
		mw isInline ifFalse: [ mw close ] ]
]

{ #category : #'t - menu item' }
TToMenuItem >> isInInlineWindow [

	self parentMenuDo: [ :m | ^ m hasInlineWindow ].
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
TToMenuItem >> rootMenuOrMenuPane [

	^ self parentMenu
		  ifNil: [
		  self menuPane
			  ifNil: [ self ]
			  ifNotNil: [ :rmp | rmp rootMenuPane ] ]
		  ifNotNil: [ :pm | pm rootMenuOrMenuPane ]
]

{ #category : #'t - menu item' }
TToMenuItem >> rootMenuOrMenuPaneDo: aBlock [

	self rootMenuOrMenuPane ifNotNil: [ :p | aBlock value: p ]
]

{ #category : #'t - menu item' }
TToMenuItem >> rootMenuWindowOrMenuPane [

	self parentChainReverseDo: [ :e |
		((e isKindOf: ToMenuWindow) or: [ e isKindOf: ToMenuPane ]) ifTrue: [
			^ e ] ].
	^ nil
]

{ #category : #'t - menu item' }
TToMenuItem >> rootMenuWindowOrMenuPaneDo: aValuable [

	self rootMenuWindowOrMenuPane ifNotNil: [ :rmc | aValuable cull: rmc ]
]

{ #category : #'t - menu item' }
TToMenuItem >> showExpandIcon [

	^ false
]
