Class {
	#name : #ToFiniteListVisibleNodeContainersChangedEvent,
	#superclass : #BlEvent,
	#instVars : [
		'invisibleNodeContainers',
		'visibleNodeContainers'
	],
	#category : #'Toplo-Widget-List-InnerList-Finite'
}

{ #category : #accessing }
ToFiniteListVisibleNodeContainersChangedEvent >> invisibleNodeContainers [

	^ invisibleNodeContainers
]

{ #category : #accessing }
ToFiniteListVisibleNodeContainersChangedEvent >> invisibleNodeContainers: anArray [

	invisibleNodeContainers := anArray
]

{ #category : #sending }
ToFiniteListVisibleNodeContainersChangedEvent >> sendTo: anObject [

	anObject finiteListVisibleNodeContainersChangedEvent: self
]

{ #category : #accessing }
ToFiniteListVisibleNodeContainersChangedEvent >> visibleNodeContainers [

	^ visibleNodeContainers
]

{ #category : #accessing }
ToFiniteListVisibleNodeContainersChangedEvent >> visibleNodeContainers: anArray [

	visibleNodeContainers := anArray
]
