Class {
	#name : #ToVisibleTabsChanged,
	#superclass : #BlEvent,
	#category : #'Toplo-Widget-TabPane-TabGroup'
}

{ #category : #sending }
ToVisibleTabsChanged >> sendTo: anObject [

	anObject visibleTabsChanged: self
]
