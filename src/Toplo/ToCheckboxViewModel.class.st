Class {
	#name : #ToCheckboxViewModel,
	#superclass : #ToBasicButtonViewModel,
	#instVars : [
		'#checked => ObservableSlot'
	],
	#category : #'Toplo-Widget-Buttons'
}

{ #category : #initialization }
ToCheckboxViewModel >> defaultCheckedIconImage [

	^ (BlElement new
		  size: 16 @ 16;
		  border: (BlBorder paint: Color gray width: 2);
		  background: (Color gray alpha: 0.2);
		  geometry: BlCircleGeometry new ).
]

{ #category : #initialization }
ToCheckboxViewModel >> defaultUnCheckedIconImage [

	^ (BlElement new
		  size: 16 @ 16;
		  border: (BlBorder paint: Color gray width: 2);
		  background: (Color gray alpha: 0.2);
		  geometry: BlCircleGeometry new ).
]

{ #category : #initialization }
ToCheckboxViewModel >> initialize [ 
	super initialize.

]

{ #category : #'api - checked change hook' }
ToCheckboxViewModel >> whenCheckedChangedDo: aBlock [
	"Inform when action block has been changed. 
	 `aBlock` receives two optional arguments: 
	 - new checked value
	 - old checled value"

	self property: #checked whenChangedDo: aBlock
]
