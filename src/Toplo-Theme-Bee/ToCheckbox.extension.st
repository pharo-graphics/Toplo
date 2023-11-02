Extension { #name : #ToCheckbox }

{ #category : #'*Toplo-Theme-Bee' }
ToCheckbox >> beeBlankCheckboxImage [

	| bar im |
	im := self defaultBlankCheckboxImage.
	bar := im childWithId: #bar.
	bar withAllStamps: #( #bar ).
	im withAllStamps: #( #'inner-image' #unchecked ).
	^ im
]

{ #category : #'*Toplo-Theme-Bee' }
ToCheckbox >> defaultBeeStyleStamps [

	^ #( #button #checkable #checkbox)
]

{ #category : #'*Toplo-Theme-Bee' }
ToCheckbox >> installBeeStyle [ 

	super installBeeStyle.
	self iconImage: self beeBlankCheckboxImage 
	
]
