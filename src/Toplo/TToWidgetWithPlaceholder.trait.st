Trait {
	#name : #TToWidgetWithPlaceholder,
	#instVars : [
		'placeholderLayer'
	],
	#category : #'Toplo-Widget-Pane'
}

{ #category : #'t - placeholder show/hide' }
TToWidgetWithPlaceholder >> hidePlaceholder [

	placeholderLayer ifNil: [ ^ self ].
	placeholderLayer parentDo: [ :p |	self removeLayer: placeholderLayer ]
]

{ #category : #'t - placeholder accessing' }
TToWidgetWithPlaceholder >> placeholder [

	^ self placeholderLayer
]

{ #category : #'t - placeholder accessing' }
TToWidgetWithPlaceholder >> placeholder: anElement [

	self placeholderLayer: anElement asPlaceholderLayer
]

{ #category : #'t - placeholder accessing' }
TToWidgetWithPlaceholder >> placeholderLayer [

	^ placeholderLayer
]

{ #category : #'t - placeholder accessing' }
TToWidgetWithPlaceholder >> placeholderLayer: aPanePlaceholderLayer [

	self placeholderLayer parentDo: [ :layer |
		self hidePlaceholder.
		placeholderLayer := aPanePlaceholderLayer.
		self showPlaceholder.
		^ self ].
	placeholderLayer := aPanePlaceholderLayer
]

{ #category : #'t - placeholder show/hide' }
TToWidgetWithPlaceholder >> showPlaceholder [

	placeholderLayer ifNil: [ ^ self ].
	placeholderLayer parentDo: [ :p | ^ self ].
	self addLayer: placeholderLayer
]
