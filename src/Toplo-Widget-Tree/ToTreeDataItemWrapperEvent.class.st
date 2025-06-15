Class {
	#name : #ToTreeDataItemWrapperEvent,
	#superclass : #BlEvent,
	#instVars : [
		'wrapper'
	],
	#category : #'Toplo-Widget-Tree-Core'
}

{ #category : #accessing }
ToTreeDataItemWrapperEvent >> wrapper [

	^ wrapper
]

{ #category : #accessing }
ToTreeDataItemWrapperEvent >> wrapper: aDataItemWrapper [

	wrapper := aDataItemWrapper
]
