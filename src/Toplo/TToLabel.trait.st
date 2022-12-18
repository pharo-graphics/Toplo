Trait {
	#name : #TToLabel,
	#traits : 'TBlAlignable',
	#classTraits : 'TBlAlignable classTrait',
	#category : #'Toplo-Widget-Label'
}

{ #category : #'api - alignment' }
TToLabel >> horizontalAlignment [

	^ self layout horizontalAlignment
]

{ #category : #'api - alignment' }
TToLabel >> horizontalAlignment: aBlHorizontalAlignment [

	self layout horizontalAlignment: aBlHorizontalAlignment
]

{ #category : #'api - alignment' }
TToLabel >> isAlignBottomCenter [
	
	self flag:'PLA todo bloc ?'.
]

{ #category : #'api - alignment' }
TToLabel >> isAlignBottomLeft [
	
	self flag:'PLA todo bloc ?'.
]

{ #category : #'api - alignment' }
TToLabel >> isAlignBottomRight [
	
	self flag:'PLA todo bloc ?'.
]

{ #category : #'api - alignment' }
TToLabel >> isAlignCenter [
	
	self flag:'PLA todo bloc ?'.
]

{ #category : #'api - alignment' }
TToLabel >> isAlignCenterLeft [
	
	self flag:'PLA todo bloc ?'.
]

{ #category : #'api - alignment' }
TToLabel >> isAlignCenterRight [
	
	self flag:'PLA todo bloc ?'.
]

{ #category : #'api - alignment' }
TToLabel >> isAlignNone [
	
	self flag:'PLA todo bloc ?'.
]

{ #category : #'api - alignment' }
TToLabel >> isAlignTopCenter [
	
	self flag:'PLA todo bloc ?'.
]

{ #category : #'api - alignment' }
TToLabel >> isAlignTopLeft [
	
	self flag:'PLA todo bloc ?'.
]

{ #category : #'api - alignment' }
TToLabel >> isAlignTopRight [
	
	self flag:'PLA todo bloc ?'.
]

{ #category : #'api - alignment' }
TToLabel >> verticalAlignment [

	^ self layout verticalAlignment
]

{ #category : #'api - alignment' }
TToLabel >> verticalAlignment: aBlVerticalAlignment [

	self layout verticalAlignment: aBlVerticalAlignment
]
