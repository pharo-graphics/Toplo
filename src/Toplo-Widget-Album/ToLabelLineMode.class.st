Class {
	#name : #ToLabelLineMode,
	#superclass : #Object,
	#classVars : [
		'Mono',
		'Multi'
	],
	#category : #'Toplo-Widget-Album-Label'
}

{ #category : #'instance creation' }
ToLabelLineMode class >> mono [

	^ Mono ifNil: [Mono := ToLabelMonoLineMode new]

]

{ #category : #'instance creation' }
ToLabelLineMode class >> multi [

	^ Multi ifNil: [Multi := ToLabelMultiLineMode new]

]

{ #category : #testing }
ToLabelLineMode >> isMonoLine [ 

	^ false
]

{ #category : #testing }
ToLabelLineMode >> isMultiLine [ 

	^ false
]

{ #category : #initialization }
ToLabelLineMode >> newTextElementIn: aLabel [

	^ self subclassResponsibility 
	
]
