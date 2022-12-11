Class {
	#name : #ToMenuWindow,
	#superclass : #ToPopupWindow,
	#category : #'Toplo-Widget-Menu'
}

{ #category : #'api - displaying' }
ToMenuWindow >> checkBeforePopupIn: aWidget [

	| minw |
	super checkBeforePopupIn: aWidget.
	minw := 0.
	self root childrenDo: [ :child |
		
		minw := minw max: child width ].
	
	"self root childrenDo: [ :child |
		child constraints minWidth: minw ].
	self requestLayout "

	
	
]

{ #category : #initialization }
ToMenuWindow >> defaultBorder [

	^ BlBorder paint: Color lightGray width: 1
]

{ #category : #'t - initialization dresser' }
ToMenuWindow >> defaultDresser [ 

	^ ToMenuWindowDresser new
]

{ #category : #initialization }
ToMenuWindow >> initialize [

	super initialize.
	self padding: (BlInsets all: 2).
	self initializeDresser 
	
]
