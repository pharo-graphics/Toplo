Class {
	#name : #ToCircularMenu,
	#superclass : #ToMenu,
	#category : #'Toplo-Widget-Menu-Items'
}

{ #category : #accessing }
ToCircularMenu >> defaultWindowMeasurement [

	^ ToNoCustomMeasurement new
]

{ #category : #accessing }
ToCircularMenu >> defaultWindowPlacement [

	^ ToCircularMenuPlacement new
]

{ #category : #'t - item list owner - initializing' }
ToCircularMenu >> newItemList [ 

	^ ToCircularMenuItemList new
]

{ #category : #accessing }
ToCircularMenu >> windowClass [ 

	^ ToCircularMenuWindow
]

{ #category : #accessing }
ToCircularMenu >> windowStarter [

	^ ToCircularMenuWindowStarter new
]
