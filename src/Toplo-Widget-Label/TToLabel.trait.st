Trait {
	#name : #TToLabel,
	#traits : 'TBlAlignable',
	#classTraits : 'TBlAlignable classTrait',
	#category : #'Toplo-Widget-Label'
}

{ #category : #'t - label alignment' }
TToLabel >> horizontalAlignment [

	^ self layout horizontalAlignment
]

{ #category : #'t - label alignment' }
TToLabel >> horizontalAlignment: aBlHorizontalAlignment [

	self layout horizontalAlignment: aBlHorizontalAlignment
]

{ #category : #'t - label alignment' }
TToLabel >> isAlignBottomCenter [
	
	self flag:'PLA todo bloc ?'.
]

{ #category : #'t - label alignment' }
TToLabel >> isAlignBottomLeft [
	
	self flag:'PLA todo bloc ?'.
]

{ #category : #'t - label alignment' }
TToLabel >> isAlignBottomRight [
	
	self flag:'PLA todo bloc ?'.
]

{ #category : #'t - label alignment' }
TToLabel >> isAlignCenter [
	
	self flag:'PLA todo bloc ?'.
]

{ #category : #'t - label alignment' }
TToLabel >> isAlignCenterLeft [
	
	self flag:'PLA todo bloc ?'.
]

{ #category : #'t - label alignment' }
TToLabel >> isAlignCenterRight [
	
	self flag:'PLA todo bloc ?'.
]

{ #category : #'t - label alignment' }
TToLabel >> isAlignNone [
	
	self flag:'PLA todo bloc ?'.
]

{ #category : #'t - label alignment' }
TToLabel >> isAlignTopCenter [
	
	self flag:'PLA todo bloc ?'.
]

{ #category : #'t - label alignment' }
TToLabel >> isAlignTopLeft [
	
	self flag:'PLA todo bloc ?'.
]

{ #category : #'t - label alignment' }
TToLabel >> isAlignTopRight [
	
	self flag:'PLA todo bloc ?'.
]

{ #category : #'t - label alignment' }
TToLabel >> verticalAlignment [

	^ self layout verticalAlignment
]

{ #category : #'t - label alignment' }
TToLabel >> verticalAlignment: aBlVerticalAlignment [

	self layout verticalAlignment: aBlVerticalAlignment
]
