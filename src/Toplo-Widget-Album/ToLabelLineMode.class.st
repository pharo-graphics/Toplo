Class {
	#name : 'ToLabelLineMode',
	#superclass : 'Object',
	#category : 'Toplo-Widget-Album-Label',
	#package : 'Toplo-Widget-Album',
	#tag : 'Label'
}

{ #category : 'testing' }
ToLabelLineMode >> isMonoLine [ 

	^ false
]

{ #category : 'testing' }
ToLabelLineMode >> isMultiLine [ 

	^ false
]

{ #category : 'initialization' }
ToLabelLineMode >> newTextElementIn: aLabel [

	^ self subclassResponsibility 
	
]
