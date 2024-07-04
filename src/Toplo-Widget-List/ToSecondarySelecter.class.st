Class {
	#name : #ToSecondarySelecter,
	#superclass : #ToListSelecter,
	#category : #'Toplo-Widget-List-Selection-Selecter'
}

{ #category : #initialization }
ToSecondarySelecter >> initialize [ 
	
	super initialize.
	commandApplierEventHandler := ToDataSourceCommandApplierEventHandler new.

]
