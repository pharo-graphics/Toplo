Class {
	#name : #ToBarVisibleNodeContainerListChangedEvent,
	#superclass : #BlEvent,
	#instVars : [
		'invisibleNodeContainers',
		'visibleNodeContainers'
	],
	#category : #'Toplo-Widget-List-InnerBar'
}

{ #category : #accessing }
ToBarVisibleNodeContainerListChangedEvent >> invisibleNodeContainers [

	^ invisibleNodeContainers
]

{ #category : #accessing }
ToBarVisibleNodeContainerListChangedEvent >> invisibleNodeContainers: anArray [

	invisibleNodeContainers := anArray
]

{ #category : #sending }
ToBarVisibleNodeContainerListChangedEvent >> sendTo: anObject [

	anObject barVisibleNodeContainerListChangedEvent: self
]

{ #category : #accessing }
ToBarVisibleNodeContainerListChangedEvent >> visibleNodeContainers [

	^ visibleNodeContainers
]

{ #category : #accessing }
ToBarVisibleNodeContainerListChangedEvent >> visibleNodeContainers: anArray [

	visibleNodeContainers := anArray
]
