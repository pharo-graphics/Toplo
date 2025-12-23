Class {
	#name : #ToTabButton,
	#superclass : #ToTabItemElement,
	#instVars : [
		'paneBuilder',
		'paneDestroyer',
		'bodyPane',
		'destroyPaneWhenDeselected',
		'paneFactory'
	],
	#category : #'Toplo-Widget-TabPane-TabPane'
}

{ #category : #accessing }
ToTabButton >> bodyPane [

	^ bodyPane
]

{ #category : #accessing }
ToTabButton >> bodyPane: anElement [

	bodyPane := anElement
]

{ #category : #accessing }
ToTabButton >> destroyPaneWhenDeselected [

	^ destroyPaneWhenDeselected
]

{ #category : #accessing }
ToTabButton >> destroyPaneWhenDeselected: aBoolean [

	destroyPaneWhenDeselected := aBoolean
]

{ #category : #initialization }
ToTabButton >> initialize [ 

	super initialize.
	destroyPaneWhenDeselected := false.
	paneBuilder := [ :pane :button :holder | ].
	paneFactory := [ ToPane new ].
	paneDestroyer := [ :theBodyPane :theTabButton :theHolder]
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

	"aValuable takes the pane to build, the tab button and its holder as arguments "
	paneBuilder := aValuable
]

{ #category : #accessing }
ToTabButton >> paneDestroyer [

	^ paneDestroyer
]

{ #category : #accessing }
ToTabButton >> paneDestroyer: aValuable [

	"aValuable takes the pane to build, the tab button and its holder as arguments "
	paneDestroyer := aValuable
]

{ #category : #accessing }
ToTabButton >> paneFactory [

	^ paneFactory
]

{ #category : #accessing }
ToTabButton >> paneFactory: aValuable [

	paneFactory := aValuable
]
