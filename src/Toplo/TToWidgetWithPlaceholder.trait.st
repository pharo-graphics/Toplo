Trait {
	#name : #TToWidgetWithPlaceholder,
	#instVars : [
		'placeholderLayer'
	],
	#category : #'Toplo-Core'
}

{ #category : #'t - placeholder show/hide' }
TToWidgetWithPlaceholder >> hidePlaceholder [

	placeholderLayer ifNil: [ ^ self ].
	placeholderLayer parentDo: [ :p |
		self removeLayer: placeholderLayer.
		self dispatchEvent: ToPlaceholderRemovedEvent new ]
]

{ #category : #'t - placeholder accessing' }
TToWidgetWithPlaceholder >> placeholder [

	^ self placeholderLayer
]

{ #category : #'t - placeholder accessing' }
TToWidgetWithPlaceholder >> placeholder: anElement [

	self placeholderLayer: (anElement ifNotNil: [:ph | ph asPlaceholderLayer ])
]

{ #category : #'t - placeholder accessing' }
TToWidgetWithPlaceholder >> placeholderLayer [

	^ placeholderLayer
]

{ #category : #'t - placeholder accessing' }
TToWidgetWithPlaceholder >> placeholderLayer: aPanePlaceholderLayer [

	self placeholderLayer ifNotNil: [
		self placeholderLayer parentDo: [ :layer |
			self hidePlaceholder.
			placeholderLayer := aPanePlaceholderLayer.
			self showPlaceholder.
			^ self ] ].
	placeholderLayer := aPanePlaceholderLayer
]

{ #category : #'t - placeholder show/hide' }
TToWidgetWithPlaceholder >> showPlaceholder [

	placeholderLayer ifNil: [ ^ self ].
	placeholderLayer parentDo: [ :p | ^ self ].
	self addLayer: placeholderLayer.
	self dispatchEvent: (ToPlaceholderAddedEvent new)
]
