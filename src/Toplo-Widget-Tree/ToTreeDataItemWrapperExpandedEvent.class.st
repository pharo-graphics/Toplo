Class {
	#name : #ToTreeDataItemWrapperExpandedEvent,
	#superclass : #ToTreeDataItemWrapperEvent,
	#instVars : [
		'deeply'
	],
	#category : #'Toplo-Widget-Tree-Core'
}

{ #category : #accessing }
ToTreeDataItemWrapperExpandedEvent >> deeply [

	^ deeply
]

{ #category : #accessing }
ToTreeDataItemWrapperExpandedEvent >> deeply: aBoolean [

	deeply := aBoolean
]

{ #category : #initialization }
ToTreeDataItemWrapperExpandedEvent >> initialize [ 

	super initialize.
	deeply := false
]

{ #category : #sending }
ToTreeDataItemWrapperExpandedEvent >> sendTo: anObject [

	anObject treeDataItemWrapperExpandedEvent: self
]
