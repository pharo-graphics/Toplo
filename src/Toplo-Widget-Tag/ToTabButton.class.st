Class {
	#name : #ToTabButton,
	#superclass : #ToTabItemElement,
	#instVars : [
		'paneBuilder'
	],
	#category : #'Toplo-Widget-Tag-Tab'
}

{ #category : #initialization }
ToTabButton >> initialize [ 

	super initialize.
	paneBuilder := [ :pane :button :node :holder | ].
]

{ #category : #accessing }
ToTabButton >> paneBuilder [

	^ paneBuilder
]

{ #category : #accessing }
ToTabButton >> paneBuilder: aValuable [

	"aValuable takes the pane to build, the tab button, its node and its holder as arguments "
	paneBuilder := aValuable
]
