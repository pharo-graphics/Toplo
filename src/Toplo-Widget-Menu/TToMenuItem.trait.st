Trait {
	#name : #TToMenuItem,
	#category : #'Toplo-Widget-Menu-Items'
}

{ #category : #'t - menu item' }
TToMenuItem >> barOwnerDo: aValuable [

	self menuBarOwner ifNotNil: [ :bo | aValuable value: bo ]
]

{ #category : #'t - menu item' }
TToMenuItem >> closeAllSiblingMenuWindows [

	| siblingWindows |
	siblingWindows := Array streamContents: [ :stream |
		                  self nextPutAllSiblingMenuWindowsIn: stream ].
	siblingWindows do: [ :w | w close ]
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
TToMenuItem >> nextPutAllSiblingMenuWindowsIn: aStream [

	self isInline ifTrue: [ ^ self ].
	self parentMenuDo: [ :pm |
			pm items do: [ :sibling |
					sibling = self ifFalse: [
							sibling isInline ifFalse: [
								sibling menuWindowDo: [ :w | aStream nextPut: w ] ] ] ] ]
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
