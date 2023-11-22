Trait {
	#name : 'TToPrimaryColorHolder',
	#category : 'Toplo-Core-Theme',
	#package : 'Toplo',
	#tag : 'Core-Theme'
}

{ #category : 't - primary color holder' }
TToPrimaryColorHolder >> colorPrimary [

	^ self rawColorPrimary ifNil: [
		  self colorPrimary: self defaultColorPrimary.
		  self rawColorPrimary ]
]

{ #category : 't - primary color holder' }
TToPrimaryColorHolder >> colorPrimary: aColor [
	"Brand color is one of the most direct visual elements to reflect the characteristics and communication of the product. After you have selected the brand color, we will automatically generate a complete color palette and assign it effective design semantics"

	self rawColorPrimary = aColor ifTrue: [ ^ self ].
	self rawColorPrimary: aColor.
	self onColorPrimaryChanged
]

{ #category : 't - primary color holder' }
TToPrimaryColorHolder >> colorPrimaryHover [

	^ self rawColorPrimaryHover 
]

{ #category : 't - primary color holder' }
TToPrimaryColorHolder >> colorPrimaryPressed [

	^ self rawColorPrimaryPressed 
]

{ #category : 't - primary color holder' }
TToPrimaryColorHolder >> defaultColorPrimary [

	^ self explicitRequirement 
]

{ #category : 't - primary color holder' }
TToPrimaryColorHolder >> onColorPrimaryChanged [

	self explicitRequirement 
]

{ #category : 't - primary color holder' }
TToPrimaryColorHolder >> rawColorPrimary [

	^ self explicitRequirement 
]

{ #category : 't - primary color holder' }
TToPrimaryColorHolder >> rawColorPrimary: aColor [

	self explicitRequirement 
]

{ #category : 't - primary color holder' }
TToPrimaryColorHolder >> rawColorPrimaryHover [

	^ self explicitRequirement 
]

{ #category : 't - primary color holder' }
TToPrimaryColorHolder >> rawColorPrimaryHover: aColor [

	self explicitRequirement 
]

{ #category : 't - primary color holder' }
TToPrimaryColorHolder >> rawColorPrimaryPressed [

	^ self explicitRequirement 
]

{ #category : 't - primary color holder' }
TToPrimaryColorHolder >> rawColorPrimaryPressed: aColor [

	self explicitRequirement 
]
