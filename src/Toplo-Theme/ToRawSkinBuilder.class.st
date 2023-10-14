Class {
	#name : 'ToRawSkinBuilder',
	#superclass : 'ToAbstractSkinBuilder',
	#category : 'Toplo-Theme-Core',
	#package : 'Toplo-Theme',
	#tag : 'Core'
}

{ #category : 'skin building' }
ToRawSkinBuilder >> skinFor: anElement [

	^ anElement rawSkin
]
