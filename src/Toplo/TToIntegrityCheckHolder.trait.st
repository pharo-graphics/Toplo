Trait {
	#name : 'TToIntegrityCheckHolder',
	#classInstVars : [
		'postponedIntegrityCheckAction'
	],
	#category : 'Toplo-Core',
	#package : 'Toplo',
	#tag : 'Core'
}

{ #category : 'accessing' }
TToIntegrityCheckHolder classSide >> postponedIntegrityCheckAction [

	^ postponedIntegrityCheckAction 
]

{ #category : 'accessing' }
TToIntegrityCheckHolder classSide >> postponedIntegrityCheckAction: aValuable [

	" aValuable takes the element to check as argument "
	postponedIntegrityCheckAction := aValuable
]

{ #category : 't - integrity check holder' }
TToIntegrityCheckHolder >> applyPostponedIntegrityCheckAction [

	self postponedIntegrityCheckAction ifNotNil: [ :action | action value: self ]
	
	
]

{ #category : 't - integrity check holder' }
TToIntegrityCheckHolder >> postponedIntegrityCheckAction [

	^ self class postponedIntegrityCheckAction
]
