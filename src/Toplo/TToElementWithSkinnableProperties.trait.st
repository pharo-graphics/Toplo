Trait {
	#name : #TToElementWithSkinnableProperties,
	#category : 'Toplo-Core-Properties'
}

{ #category : #accessing }
TToElementWithSkinnableProperties classSide >> newPropertyIndex [ 

	^ self explicitRequirement 
]

{ #category : #'t - element with skinnable properties' }
TToElementWithSkinnableProperties >> propertyIndex [

	^ self userData at: #propertyIndex ifAbsentPut: [self class newPropertyIndex]
]

{ #category : #'t - element with skinnable properties' }
TToElementWithSkinnableProperties >> propertyNamed: aSymbol [

	^ self propertyIndex at: aSymbol asSymbol ifAbsent: [  ]
]
