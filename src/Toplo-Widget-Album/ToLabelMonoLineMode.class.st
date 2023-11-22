Class {
	#name : 'ToLabelMonoLineMode',
	#superclass : 'ToLabelLineMode',
	#category : 'Toplo-Widget-Album-Label',
	#package : 'Toplo-Widget-Album',
	#tag : 'Label'
}

{ #category : 'initialization' }
ToLabelMonoLineMode >> isMonoLine [ 

	^ true
]

{ #category : 'initialization' }
ToLabelMonoLineMode >> newTextElementIn: aLabel [

	^ ToLabelMonoLineInnerElement new
]
