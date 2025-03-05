Class {
	#name : #ToVisibleTabsChanged,
	#superclass : #BlEvent,
	#category : #'Toplo-Widget-Tag-Tab'
}

{ #category : #sending }
ToVisibleTabsChanged >> sendTo: anObject [

	anObject visibleTabsChanged: self
]
