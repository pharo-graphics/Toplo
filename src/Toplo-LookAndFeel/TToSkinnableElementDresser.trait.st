Trait {
	#name : #TToSkinnableElementDresser,
	#instVars : [
		'skin'
	],
	#category : #'Toplo-LookAndFeel-Dressers'
}

{ #category : #accessing }
TToSkinnableElementDresser >> defaultSkin [

	^ ToAbstractTheme current class skinFor: self defaultToElementClass type: self defaultSkinType
]

{ #category : #accessing }
TToSkinnableElementDresser >> defaultSkinType [

	^ ToAbstractSkin defaultType
]

{ #category : #accessing }
TToSkinnableElementDresser >> defaultToElementClass [

	^ self shouldBeImplemented
]

{ #category : #accessing }
TToSkinnableElementDresser >> haveCompatibleSkin [

	^ self isSkinCompatible: self skin
]

{ #category : #accessing }
TToSkinnableElementDresser >> isSkinCompatible: aSkin [

	aSkin ifNil:[ ^ false ].
	^ true
]

{ #category : #accessing }
TToSkinnableElementDresser >> skin [

	^ skin ifNil: [ skin := self defaultSkin ]
]
