Class {
	#name : #ToWidget,
	#superclass : #BlElement,
	#traits : 'TBlAnnouncerProvider + TToObservable + TToEnableable',
	#classTraits : 'TBlAnnouncerProvider classTrait + TToObservable classTrait + TToEnableable classTrait',
	#category : #'Toplo-Core'
}

{ #category : #'api - tooltip' }
ToWidget >> checkTooltip [

	self tooltip ifNil: [ self tooltip: self newTooltipWidget ]
]

{ #category : #initialization }
ToWidget >> defaultDresser [

	^ ToNullDresser new

]

{ #category : #initialization }
ToWidget >> defaultLayout [

	^ BlLinearLayout horizontal 
]

{ #category : #initialization }
ToWidget >> defaultViewModel [

	^ self subclassResponsibility
]

{ #category : #'accessing - dresser' }
ToWidget >> dresser [
	^ self userData at: #dresser ifAbsent: nil
]

{ #category : #'accessing - dresser' }
ToWidget >> dresser: aDresser [

	self dresserDo: [ :d  | d launchUninstallationIn: self ].
	self userData at: #dresser put: aDresser.
	self dresserDo: [ :d  | d launchInstallationIn: self ].

]

{ #category : #'accessing - dresser' }
ToWidget >> dresserDo: aBlock [
	self dresser ifNotNil: aBlock
]

{ #category : #initialization }
ToWidget >> initialize [

	self class initializeSlots: self.
	super initialize.
	self dresser: self defaultDresser
]

{ #category : #'change reporting' }
ToWidget >> invalidate [

	self invalidateModel.
	^ super invalidate
]

{ #category : #'change reporting' }
ToWidget >> invalidateModel [

	self viewModelDo: [ :vm | vm invalidate ]
	
	
]

{ #category : #'api - tooltip' }
ToWidget >> newTooltipWidget [

	^ self tooltipWidgetClass new
]

{ #category : #world }
ToWidget >> openInFrame [

	| frame |
	frame := ToFrame new.
	frame addChild: self.
	frame openInWorld
]

{ #category : #world }
ToWidget >> openInWorld [

	| world |
	world := ToManager world.
	world isOpened ifFalse: [ world show ].
	world root addChild: self
]

{ #category : #accessing }
ToWidget >> tooltip [

	^ self userData at: #tooltip ifAbsent: [  ]
]

{ #category : #accessing }
ToWidget >> tooltip: aTooltip [

	self userData at: #tooltip put: aTooltip
]

{ #category : #'api - tooltip' }
ToWidget >> tooltipContent [

	^ self tooltip ifNotNil: [ :tooltip | tooltip content ]
]

{ #category : #'api - tooltip' }
ToWidget >> tooltipContent: aTooltipContent [

	self checkTooltip.
	self tooltip content: aTooltipContent asRopedText

]

{ #category : #accessing }
ToWidget >> tooltipDo: aBlock [

	self tooltip
		ifNil: [ ^ self ]
		ifNotNil: [ :tooltip | aBlock value: tooltip ]
]

{ #category : #'api - tooltip' }
ToWidget >> tooltipString: aString [

	"Set a help string to display to the user if he let the mouse over the widget (a tooltip)."

	self tooltipContent: aString asRopedText
]

{ #category : #'api - tooltip' }
ToWidget >> tooltipWidgetClass [

	^ ToTooltip 
]

{ #category : #accessing }
ToWidget >> viewModel [

	" should be lazy to avoid unecessary instanciation and installation "
	^ self userData at: #viewModel ifAbsent: [  ]
]

{ #category : #accessing }
ToWidget >> viewModel: aViewModel [

	" A viewModel is normally installed only once by the widget or by the viewModel itself.
	Installing a new viewModel is possible but be aware of what you are doing (lost of data stored in the installed viewModel)."
	self viewModelDo: [ :aCurrentModel | aCurrentModel launchUninstallationIn: self ].
	self userData at: #viewModel put: aViewModel.
	self viewModelDo: [ :aCurrentModel | aViewModel launchInstallationIn: self ]
]

{ #category : #accessing }
ToWidget >> viewModelDo: aBlock [

	self viewModel ifNotNil: aBlock
]

{ #category : #'private - model events' }
ToWidget >> whenActionRequired: anActionRequiredFromCompagnon [

	anActionRequiredFromCompagnon value: self
]

{ #category : #'api - properties change hook' }
ToWidget >> whenTooltipChangedDo: aBlock [
	"Inform when tooltip property has changed. 
	 `aBlock` has three optional arguments: 
	 - new value
	 - old value
	 - the announcement triggering this action"

	self checkTooltip.
	self tooltip whenContentChangedDo: aBlock
]
