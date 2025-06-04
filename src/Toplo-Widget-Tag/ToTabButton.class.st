Class {
	#name : #ToTabButton,
	#superclass : #ToTabItemElement,
	#instVars : [
		'paneBuilder',
		'paneDestroyer'
	],
	#category : #'Toplo-Widget-Tag-Tab'
}

{ #category : #accessing }
ToTabButton >> detroyPaneWhenDeselected [
	"aValuable takes the pane to build, the tab button, its node and its holder as arguments "

	self paneDestroyer ifNotNil: [ ^ self ].
	self paneDestroyer: [ :pane |  ]
]

{ #category : #initialization }
ToTabButton >> initialize [ 

	super initialize.
	paneBuilder := [ :pane :button :node :holder | ]
]

{ #category : #skin }
ToTabButton >> newRawSkin [ 

	^ ToTabButtonSkin new
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

{ #category : #accessing }
ToTabButton >> paneDestroyer [

	^ paneDestroyer
]

{ #category : #accessing }
ToTabButton >> paneDestroyer: aValuable [

	"aValuable takes the pane to build, the tab button, its node and its holder as arguments "
	paneDestroyer := aValuable
]
