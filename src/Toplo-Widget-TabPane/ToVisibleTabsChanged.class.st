Class {
	#name : #ToVisibleTabsChanged,
	#superclass : #BlEvent,
	#category : #'Toplo-Widget-TabPane'
}

{ #category : #sending }
ToVisibleTabsChanged >> sendTo: anObject [

	anObject visibleTabsChanged: self
]
